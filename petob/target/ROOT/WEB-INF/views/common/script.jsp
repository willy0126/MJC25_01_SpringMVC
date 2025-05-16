<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
<%-- jQuery --%>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<%-- jQuery Validation --%>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/additional-methods.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', () => {
    // 메인 캐러셀 fade-in
    const carousel = document.querySelector('.carousel.fade-in');
    if (carousel) {
    // delay for 100ms
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

    // 3) mini-carousel 자동 전환
    const miniSlides = document.querySelectorAll('.mini-carousel .slide');
    if (miniSlides.length > 0) {
      let currentMini = 0;
      setInterval(() => {
        miniSlides[currentMini].classList.remove('active');
        currentMini = (currentMini + 1) % miniSlides.length;
        miniSlides[currentMini].classList.add('active');
      }, 3000);
    }
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/tinymce@7.5.1/tinymce.min.js"></script>