<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="${pageContext.request.contextPath}/resources/js/app.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        // carousel fade-in 효과 적용
        const carousel = document.querySelector('.carousel.fade-in');
        if (carousel) {
            setTimeout(() => carousel.classList.add('show'), 100);
        }

        // IntersectionObserver를 사용하여 fade-in 효과 적용
        const targets = document.querySelectorAll(
            '.section-title, .intro-item, #procedure, #notices .notice-list, #notices .mini-carousel, section.fade-in'
        );
        if (targets.length) {
            const io = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('show');
                        observer.unobserve(entry.target);
                    }
                });
            }, {
                threshold: 0.25,
                rootMargin: '0px 0px -10% 0px'
            });
            targets.forEach(el => io.observe(el));
        }

        // mini-carousel 자동 전환
        const miniSlides = document.querySelectorAll('.mini-carousel .slide');
        if (miniSlides.length > 0) {
            let currentMini = 0;
            setInterval(() => {
                miniSlides[currentMini].classList.remove('active');
                currentMini = (currentMini + 1) % miniSlides.length;
                miniSlides[currentMini].classList.add('active');
            }, 3000);
        }

        /*
        // 이미지 캐러셀 기능 추가
        const mainImage = document.getElementById('mainImage');
        const carouselItems = document.querySelectorAll('.carousel-item');

        if (mainImage && carouselItems.length > 0) {
            carouselItems.forEach(item => {
                item.addEventListener('click', function() {
                    const imageUrl = this.dataset.image;
                    mainImage.src = imageUrl;

                    carouselItems.forEach(el => el.classList.remove('active'));
                    this.classList.add('active');
                });
            });
        }
        */
    });
</script>