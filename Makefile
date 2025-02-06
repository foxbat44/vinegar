.POSIX:

VERSION = v1.7.8

PREFIX     = /usr
APPPREFIX  = $(PREFIX)/share/applications
ICONPREFIX = $(PREFIX)/share/icons/hicolor

GO          = go
GO_LDFLAGS  = -s -w -X main.version=$(VERSION)

# for automatically re-building
SOURCES != find . -type f -name "*.go"

all: vinegar

vinegar: $(SOURCES) cmd/vinegar/vinegar.gresource
	$(GO) build $(GOFLAGS) -ldflags="$(GO_LDFLAGS)" ./cmd/vinegar

cmd/vinegar/vinegar.gresource: data/vinegar.gresource.xml
	glib-compile-resources --sourcedir=data --target=cmd/vinegar/vinegar.gresource $^

install: vinegar
	install -Dm755 vinegar $(DESTDIR)$(PREFIX)/bin/vinegar
	install -Dm644 data/org.vinegarhq.Vinegar.metainfo.xml -t $(DESTDIR)$(PREFIX)/share/metainfo
	install -Dm644 data/desktop/vinegar.desktop $(DESTDIR)$(APPPREFIX)/org.vinegarhq.Vinegar.desktop
	install -Dm644 data/desktop/roblox-studio.desktop $(DESTDIR)$(APPPREFIX)/org.vinegarhq.Vinegar.studio.desktop
	install -Dm644 data/icons/vinegar.svg $(DESTDIR)$(ICONPREFIX)/scalable/apps/org.vinegarhq.Vinegar.svg
	install -Dm644 data/icons/roblox-studio.svg $(DESTDIR)$(ICONPREFIX)/scalable/apps/org.vinegarhq.Vinegar.studio.svg
	gtk-update-icon-cache -f -t $(DESTDIR)$(ICONPREFIX) ||:

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/vinegar
	rm -f $(DESTDIR)$(PREFIX)/share/metainfo/org.vinegarhq.Vinegar.metainfo.xml
	rm -f $(DESTDIR)$(APPPREFIX)/org.vinegarhq.Vinegar.desktop
	rm -f $(DESTDIR)$(APPPREFIX)/org.vinegarhq.Vinegar.studio.desktop
	rm -f $(DESTDIR)$(ICONPREFIX)/scalable/apps/org.vinegarhq.Vinegar.svg
	rm -f $(DESTDIR)$(ICONPREFIX)/scalable/apps/org.vinegarhq.Vinegar.studio.svg

clean:
	rm -f vinegar
	
.PHONY: all install uninstall clean
