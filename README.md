# m3shapes-overlay

A Gentoo overlay for [m3shapes](https://github.com/soramanew/m3shapes), a Qt6 QML plugin that provides Material Design 3 shapes with morph animation (used by Quickshell-based desktop shells like caelestia-dots/shell).

Provides: `dev-qt/m3shapes`

## Setup

```bash
sudo tee /etc/portage/repos.conf/m3shapes-overlay.conf << 'EOF'
[m3shapes-overlay]
location = /var/db/repos/m3shapes-overlay
sync-type = git
sync-uri = https://github.com/thehazell/m3shapes-overlay.git
auto-sync = yes
EOF

sudo emaint sync --repo m3shapes-overlay
```

## Install

```bash
echo "dev-qt/m3shapes::m3shapes-overlay **" | sudo tee /etc/portage/package.accept_keywords/m3shapes
sudo emerge --ask dev-qt/m3shapes
```

Add `USE=examples` if you also want the `ShapeGallery` demo app.