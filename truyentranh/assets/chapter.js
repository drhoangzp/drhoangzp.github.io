$(document).ready(function () {
    // Customize read story
    const chapterContent = $('.chapter-content')

    const settingFont = $('.setting-font')
    settingFont.on('change', function (e) {
        window.setCookie('font_chapter', $(this).val(), 1)
        const targetFontConfig = window.objConfigFont.find((item) => {
            return item.name == $(this).val()
        })
        chapterContent.css('font-family', targetFontConfig.value)
        // window.location.reload()
    })

    const settingFontSize = $('.setting-font-size')
    settingFontSize.on('change', function (e) {
        window.setCookie('font_size_chapter', $(this).val(), 1)
        chapterContent.css('font-size', $(this).val() + 'px')
        // window.location.reload()
    })

    const settingLineHeight = $('.setting-line-height')
    settingLineHeight.on('change', function (e) {
        window.setCookie('line_height_chapter', $(this).val(), 1)
        chapterContent.css('line-height', $(this).val() + '%')
    })

    const chapterJump = $('.chapter_jump')
    $(document).keydown(function (e) {
        switch (e.which) {
            case 87: // W key
                window.scrollBy(0, -70);
                break;
            case 83: // S key
                window.scrollBy(0, 70);
                break;
            case 65: // A key
                const chapterPrev = document.querySelector('.chapter-prev')
                chapterPrev && chapterPrev.click()
                break;
            case 68: // D key
                const chapterNext = document.querySelector('.chapter-next')
                chapterNext && chapterNext.click()
                break;
        }

        // Handle save cookie chapters
        
    });

    document.addEventListener('scroll', function () {
        if (window.innerWidth < 992) {
            var chapterActionsOrigin = document.querySelector('.chapter-actions-origin');
            var chapterActionsMobile = document.querySelector('.chapter-actions-mobile');

            if (chapterActionsOrigin && chapterActionsMobile) {
                var position = chapterActionsOrigin.getBoundingClientRect();

                // checking whether fully visible
                if (position.top >= 0 && position.bottom <= window.innerHeight) {
                    chapterActionsMobile.classList.remove('show')
                } else {
                    chapterActionsMobile.classList.add('show')
                }
            }
        }
    });

    // Handle history chapter reading 
})