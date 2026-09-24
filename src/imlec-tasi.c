/* İmleci ekranda verilen noktaya taşır: imlec-tasi X Y
 * KWin'in org_kde_kwin_fake_input arayüzünü kullanır. Wayland geliştirme başlıkları
 * kurulu olmadığı için gereken tanımlar burada elle yapılmıştır.
 * Derleme: gcc -O2 -o ~/.local/bin/imlec-tasi imlec-tasi.c /usr/lib/x86_64-linux-gnu/libwayland-client.so.0 */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct wl_interface;
struct wl_message { const char *name; const char *signature; const struct wl_interface **types; };
struct wl_interface {
    const char *name; int version;
    int method_count; const struct wl_message *methods;
    int event_count; const struct wl_message *events;
};
struct wl_display;
struct wl_proxy;

extern const struct wl_interface wl_registry_interface;
struct wl_display *wl_display_connect(const char *name);
int wl_display_roundtrip(struct wl_display *display);
void wl_display_disconnect(struct wl_display *display);
struct wl_proxy *wl_proxy_marshal_constructor(struct wl_proxy *proxy, uint32_t opcode,
                                              const struct wl_interface *interface, ...);
struct wl_proxy *wl_proxy_marshal_constructor_versioned(struct wl_proxy *proxy, uint32_t opcode,
                                                        const struct wl_interface *interface,
                                                        uint32_t version, ...);
void wl_proxy_marshal(struct wl_proxy *proxy, uint32_t opcode, ...);
int wl_proxy_add_listener(struct wl_proxy *proxy, void (**implementation)(void), void *data);

static const struct wl_interface *no_types[] = { NULL, NULL, NULL };
static const struct wl_message fake_input_requests[] = {
    { "authenticate", "ss", no_types },
    { "pointer_motion", "ff", no_types },
    { "button", "uu", no_types },
    { "axis", "uf", no_types },
    { "touch_down", "2uff", no_types },
    { "touch_motion", "2uff", no_types },
    { "touch_up", "2u", no_types },
    { "touch_cancel", "2", no_types },
    { "touch_frame", "2", no_types },
    { "pointer_motion_absolute", "3ff", no_types },
    { "keyboard_key", "4uu", no_types },
};
static const struct wl_interface fake_input_interface = {
    "org_kde_kwin_fake_input", 4, 11, fake_input_requests, 0, NULL,
};

enum { REGISTRY_BIND = 0, DISPLAY_GET_REGISTRY = 1, AUTHENTICATE = 0, POINTER_MOTION_ABSOLUTE = 9 };

static struct wl_proxy *fake_input;

static void global(void *data, struct wl_proxy *registry, uint32_t name, const char *interface, uint32_t version)
{
    (void)data;
    if (strcmp(interface, fake_input_interface.name) == 0 && version >= 3) {
        uint32_t v = version < 4 ? version : 4;
        fake_input = wl_proxy_marshal_constructor_versioned(registry, REGISTRY_BIND, &fake_input_interface, v,
                                                            name, interface, v, NULL);
    }
}

static void global_remove(void *data, struct wl_proxy *registry, uint32_t name)
{
    (void)data; (void)registry; (void)name;
}

int main(int argc, char **argv)
{
    if (argc != 3) {
        fprintf(stderr, "kullanım: %s X Y\n", argv[0]);
        return 2;
    }
    struct wl_display *display = wl_display_connect(NULL);
    if (!display) {
        fprintf(stderr, "Wayland'e bağlanılamadı\n");
        return 1;
    }
    struct wl_proxy *registry = wl_proxy_marshal_constructor((struct wl_proxy *)display, DISPLAY_GET_REGISTRY,
                                                             &wl_registry_interface, NULL);
    void (*listener[])(void) = { (void (*)(void))global, (void (*)(void))global_remove };
    wl_proxy_add_listener(registry, listener, NULL);
    wl_display_roundtrip(display);
    if (!fake_input) {
        fprintf(stderr, "KWin fake input arayüzü verilmedi (masaüstü dosyası eksik olabilir)\n");
        wl_display_disconnect(display);
        return 1;
    }
    wl_proxy_marshal(fake_input, AUTHENTICATE, "imlec-tasi", "Sanal klavye kapanınca imleci dock'tan uzaklaştırır");
    wl_proxy_marshal(fake_input, POINTER_MOTION_ABSOLUTE, (int32_t)(atof(argv[1]) * 256), (int32_t)(atof(argv[2]) * 256));
    wl_display_roundtrip(display);
    wl_display_disconnect(display);
    return 0;
}
