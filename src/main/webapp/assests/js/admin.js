document.addEventListener("DOMContentLoaded", function () {
    const sidebar = document.getElementById("admin-sidebar");
    const overlay = document.getElementById("sidebar-overlay");
    const openButton = document.getElementById("sidebar-open");
    const closeButton = document.getElementById("sidebar-close");
    const brandTrigger = document.getElementById("sidebar-brand-trigger");

    function openSidebar() {
        if (!sidebar) return;
        sidebar.classList.remove("-translate-x-full");
        if (overlay) overlay.classList.remove("hidden");
        document.body.classList.add("overflow-hidden");
        if (closeButton) closeButton.classList.remove("hidden");
        if (openButton) openButton.setAttribute("aria-expanded", "true");
    }

    function closeSidebar() {
        if (!sidebar) return;
        sidebar.classList.add("-translate-x-full");
        if (overlay) overlay.classList.add("hidden");
        document.body.classList.remove("overflow-hidden");
        if (closeButton) closeButton.classList.add("hidden");
        if (openButton) openButton.setAttribute("aria-expanded", "false");
    }

    if (brandTrigger) {
        brandTrigger.addEventListener("mouseenter", function () {
            if (window.innerWidth < 1024) {
                openSidebar();
            }
        });
    }

    if (openButton) {
        openButton.setAttribute("aria-expanded", "false");
        openButton.addEventListener("click", function () {
            const isOpen = !sidebar.classList.contains("-translate-x-full");
            if (isOpen) {
                closeSidebar();
            } else {
                openSidebar();
            }
        });
    }

    if (closeButton) {
        closeButton.addEventListener("click", closeSidebar);
    }

    if (overlay) {
        overlay.addEventListener("click", closeSidebar);
    }

    if (sidebar) {
        const links = sidebar.querySelectorAll("a");
        links.forEach(function (link) {
            link.addEventListener("click", function () {
                if (window.innerWidth < 1024) {
                    closeSidebar();
                }
            });
        });
    }

    document.addEventListener("keydown", function (event) {
        if (event.key === "Escape" && window.innerWidth < 1024) {
            closeSidebar();
        }
    });

    window.addEventListener("resize", function () {
        if (window.innerWidth >= 1024) {
            if (sidebar) sidebar.classList.remove("-translate-x-full");
            if (overlay) overlay.classList.add("hidden");
            document.body.classList.remove("overflow-hidden");
            if (closeButton) closeButton.classList.add("hidden");
            if (openButton) openButton.setAttribute("aria-expanded", "true");
        } else {
            if (sidebar) sidebar.classList.add("-translate-x-full");
            if (closeButton) closeButton.classList.add("hidden");
            if (openButton) openButton.setAttribute("aria-expanded", "false");
        }
    });
});
