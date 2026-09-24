// Maliit siyah tema: tuşlar yuvarlak köşeli çerçeveli. Ayarlar: @HOME@/.config/maliit-siyah/stil.conf
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12
import Qt.labs.settings 1.1

T.ToolButton {
    id: control

    Settings {
        id: cfg
        fileName: "@HOME@/.config/maliit-siyah/stil.conf"
        property color tusRengi: "#121212"
        property color basiliRenk: "#3a3a3a"
        property color cerceveRengi: "#5a5a5a"
        property real cerceveKalinligi: 1
        property real koseYaricapi: 6
        property color yaziRengi: "#ffffff"
    }

    Material.foreground: cfg.yaziRengi

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    icon.width: 24
    icon.height: 24
    icon.color: cfg.yaziRengi

    contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display

        icon: control.icon
        text: control.text
        font: control.font
        color: cfg.yaziRengi
    }

    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 40
        radius: cfg.koseYaricapi
        color: control.down || control.checked ? cfg.basiliRenk : cfg.tusRengi
        border.width: cfg.cerceveKalinligi
        border.color: cfg.cerceveRengi
    }
}
