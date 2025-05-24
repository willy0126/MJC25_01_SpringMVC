<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <%-- jQuery --%>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
        <%-- jQuery Validation --%>
            <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/additional-methods.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/tinymce@7.5.1/tinymce.min.js"></script>
            
            <script>
                document.addEventListener('DOMContentLoaded', () => {
                    // carousel fade-in 효과 적용 (기존 로직)
                    const carousel = document.querySelector('.carousel.fade-in');
                    if (carousel) {
                        setTimeout(() => carousel.classList.add('show'), 100);
                    }

                    // IntersectionObserver를 사용하여 fade-in 효과 적용 (기존 로직)
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

                    // 3) mini-carousel 자동 전환
                    const miniSlides = document.querySelectorAll('.mini-carousel .slide');
                    if (miniSlides.length > 0) {
                        let currentMini = 0;
                        setInterval(() => {
                            if (miniSlides[currentMini]) { // 현재 슬라이드가 존재하는지 확인
                                miniSlides[currentMini].classList.remove('active');
                            }
                            currentMini = (currentMini + 1) % miniSlides.length;
                            if (miniSlides[currentMini]) { // 다음 슬라이드가 존재하는지 확인
                                miniSlides[currentMini].classList.add('active');
                            }
                        }, 3000);
                    }

                    // =====================================================================
                    // 추가된 스크립트: '.content-fade-in' 요소들에 대한 페이지 로드 시 애니메이션
                    // (예: mainbranch.jsp의 제목, 캐러셀, 설명 텍스트 등)
                    // =====================================================================
                    const contentFadeInElements = document.querySelectorAll('.content-fade-in');
                    if (contentFadeInElements.length > 0) {
                        contentFadeInElements.forEach(function (element) {
                            setTimeout(function () {
                                element.classList.add('show');
                            }, 100);
                        });
                    }
                });
            </script>