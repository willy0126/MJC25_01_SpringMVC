package com.example.spring.FuneralReview;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.UUID;
// import org.springframework.web.multipart.MultipartFile; // 중복된 import문, 아래에 하나만 남김
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.beans.factory.annotation.Value; // 현재 코드에서는 사용하지 않으므로 주석 처리 또는 삭제 가능
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/funeral-reviews")
public class FuneralReviewController {

    @Autowired
    FuneralReviewService funeralReviewService;

    @Autowired
    ServletContext servletContext;

    private static final Logger logger = LoggerFactory.getLogger(FuneralReviewController.class);

    // 웹 애플리케이션 내부의 'uploads/funeral-reviews' 폴더를 기준으로 경로 반환
    private String getUploadPath() {
        String relativePath = "/uploads/funeral-reviews/";
        String absolutePath = servletContext.getRealPath(relativePath);

        // 디렉토리가 존재하지 않으면 생성
        File uploadDir = new File(absolutePath);
        if (!uploadDir.exists()) {
            if (uploadDir.mkdirs()) {
                logger.info("업로드 디렉토리 생성 성공: {}", absolutePath);
            } else {
                logger.error("업로드 디렉토리 생성 실패: {}", absolutePath);
                // 디렉토리 생성 실패 시 예외를 발생시키거나, 기본 경로를 사용하도록 처리할 수 있습니다.
                // 여기서는 로깅만 하고 진행하지만, 실제 운영에서는 더 강력한 처리가 필요할 수 있습니다.
            }
        }
        return absolutePath;
    }

    // (listGet, createGet, createPost, readGet, updateGet, updatePost, deletePost,
    // download 메서드는 이전과 동일하게 유지)
    // ... 이전 코드 생략 ...

    @GetMapping("")
    public String listGet(
            @RequestParam(required = false) String searchType,
            @RequestParam(required = false) String searchKeyword,
            @RequestParam(value = "page", defaultValue = "1") int currentPage,
            Model model) {
        int listCountPerPage = 10;
        int pageCountPerPage = 5;

        Map<String, Object> result = funeralReviewService.list(
                currentPage, listCountPerPage, pageCountPerPage, searchType, searchKeyword);

        model.addAttribute("posts", result.get("posts"));
        model.addAttribute("pagination", result.get("pagination"));
        model.addAttribute("searchType", result.get("searchType"));
        model.addAttribute("searchKeyword", result.get("searchKeyword"));

        return "funeralReview/list";
    }

    @GetMapping("/create")
    public String createGet(HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        return "funeralReview/create";
    }

    @PostMapping("/create")
    public String createPost(
            FuneralReviewDTO post,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/login";
        }
        post.setUserId(userId);

        String uploadPath = getUploadPath();

        try {
            MultipartFile uploadFile = post.getUploadFile();

            if (uploadFile != null && !uploadFile.isEmpty()) {
                String originalFileName = uploadFile.getOriginalFilename();
                String extension = "";
                if (originalFileName != null && originalFileName.lastIndexOf(".") != -1) {
                    extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                }
                String fileName = UUID.randomUUID().toString() + extension;

                File fileToUpload = new File(uploadPath + File.separator + fileName);
                uploadFile.transferTo(fileToUpload);

                post.setFileName(fileName);
                post.setOriginalFileName(originalFileName);
            }

            int createdId = funeralReviewService.create(post);

            if (createdId > 0) {
                redirectAttributes.addFlashAttribute("successMessage", "게시글이 등록되었습니다.");
                return "redirect:/funeral-reviews/" + createdId;
            }

            redirectAttributes.addFlashAttribute("errorMessage", "게시글 등록에 실패했습니다.");
            return "redirect:/funeral-reviews/create";

        } catch (IOException | IllegalStateException e) {
            logger.error("파일 업로드 오류: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "파일 업로드 중 오류가 발생했습니다.");
            return "redirect:/funeral-reviews/create";
        }
    }

    @GetMapping("/{id}")
    public String readGet(@PathVariable("id") int id, Model model, HttpSession session) {
        FuneralReviewDTO post = funeralReviewService.read(id);
        if (post == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "게시글을 찾을 수 없습니다.");
        }
        model.addAttribute("post", post);
        model.addAttribute("currentUserId", session.getAttribute("userId"));
        model.addAttribute("currentUserRole", session.getAttribute("role"));
        return "funeralReview/read";
    }

    @GetMapping("/{id}/update")
    public String updateGet(@PathVariable("id") int id, Model model, HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        String currentUserId = (String) session.getAttribute("userId");
        String currentUserRole = (String) session.getAttribute("role");

        FuneralReviewDTO post = funeralReviewService.read(id);

        if (post == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "존재하지 않는 게시글입니다.");
            return "redirect:/funeral-reviews";
        }

        if (currentUserId == null || (!currentUserId.equals(post.getUserId())
                && (currentUserRole == null || !currentUserRole.equals("ADMIN")))) {
            redirectAttributes.addFlashAttribute("errorMessage", "수정 권한이 없습니다.");
            return "redirect:/funeral-reviews/" + id;
        }

        model.addAttribute("post", post);
        return "funeralReview/update";
    }

    @PostMapping("/{id}/update")
    public String updatePost(
            @PathVariable("id") int id,
            FuneralReviewDTO post,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession();
        String currentUserId = (String) session.getAttribute("userId");
        String currentUserRole = (String) session.getAttribute("role");

        FuneralReviewDTO originalPost = funeralReviewService.read(id);

        if (originalPost == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "존재하지 않는 게시글입니다.");
            return "redirect:/funeral-reviews";
        }

        if (currentUserId == null || (!currentUserId.equals(originalPost.getUserId())
                && (currentUserRole == null || !currentUserRole.equals("ADMIN")))) {
            redirectAttributes.addFlashAttribute("errorMessage", "수정 권한이 없습니다.");
            return "redirect:/funeral-reviews/" + id;
        }

        post.setId(id);
        post.setUserId(originalPost.getUserId());

        String uploadPath = getUploadPath();

        try {
            MultipartFile uploadFile = post.getUploadFile();

            if (post.isDeleteFile()) {
                if (originalPost.getFileName() != null) {
                    Path filePath = Paths.get(uploadPath).resolve(originalPost.getFileName());
                    Files.deleteIfExists(filePath);
                }
                post.setFileName(null);
                post.setOriginalFileName(null);
            }

            if (uploadFile != null && !uploadFile.isEmpty()) {
                if (!post.isDeleteFile() && originalPost.getFileName() != null) {
                    Path oldFilePath = Paths.get(uploadPath).resolve(originalPost.getFileName());
                    Files.deleteIfExists(oldFilePath);
                }

                String originalFileName = uploadFile.getOriginalFilename();
                String extension = "";
                if (originalFileName != null && originalFileName.lastIndexOf(".") != -1) {
                    extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                }
                String newFileName = UUID.randomUUID().toString() + extension;

                File fileToUpload = new File(uploadPath + File.separator + newFileName);
                uploadFile.transferTo(fileToUpload);

                post.setFileName(newFileName);
                post.setOriginalFileName(originalFileName);
            } else if (!post.isDeleteFile()) {
                post.setFileName(originalPost.getFileName());
                post.setOriginalFileName(originalPost.getOriginalFileName());
            }

            boolean updated = funeralReviewService.update(post);

            if (updated) {
                redirectAttributes.addFlashAttribute("successMessage", "게시글이 수정되었습니다.");
                return "redirect:/funeral-reviews/" + id;
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "게시글 수정에 실패했습니다.");
                return "redirect:/funeral-reviews/" + id + "/update";
            }

        } catch (IOException | IllegalStateException e) {
            logger.error("파일 처리 오류: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "파일 처리 중 오류가 발생했습니다.");
            return "redirect:/funeral-reviews/" + id + "/update";
        }
    }

    @PostMapping("/{id}/delete")
    public String deletePost(
            @PathVariable("id") int id,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        String currentUserId = (String) session.getAttribute("userId");
        String currentUserRole = (String) session.getAttribute("role");

        FuneralReviewDTO originalPost = funeralReviewService.read(id);

        if (originalPost == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "존재하지 않는 게시글입니다.");
            return "redirect:/funeral-reviews";
        }

        if (currentUserId == null || (!currentUserId.equals(originalPost.getUserId())
                && (currentUserRole == null || !currentUserRole.equals("ADMIN")))) {
            redirectAttributes.addFlashAttribute("errorMessage", "삭제 권한이 없습니다.");
            return "redirect:/funeral-reviews/" + id;
        }

        String uploadPath = getUploadPath();

        try {
            if (originalPost.getFileName() != null) {
                Path filePath = Paths.get(uploadPath).resolve(originalPost.getFileName());
                Files.deleteIfExists(filePath);
            }

            boolean deleted = funeralReviewService.delete(id);

            if (deleted) {
                redirectAttributes.addFlashAttribute("successMessage", "게시글이 삭제되었습니다.");
                return "redirect:/funeral-reviews";
            }

            redirectAttributes.addFlashAttribute("errorMessage", "게시글 삭제에 실패했습니다.");
            return "redirect:/funeral-reviews/" + id;

        } catch (IOException e) {
            logger.error("파일 삭제 오류: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "업로드 파일 삭제 중 오류가 발생했습니다.");
            return "redirect:/funeral-reviews/" + id;
        }
    }

    @GetMapping("/{id}/download")
    public ResponseEntity<Resource> download(@PathVariable("id") int id) {
        FuneralReviewDTO post = funeralReviewService.read(id);

        if (post == null || post.getFileName() == null || post.getFileName().isEmpty()) {
            logger.warn("다운로드 요청 실패: 게시글 또는 파일 정보 없음. 게시글 ID {}", id);
            return ResponseEntity.notFound().build();
        }

        String uploadPath = getUploadPath();
        Path filePath = Paths.get(uploadPath).resolve(post.getFileName()).normalize();

        try {
            Resource resource = new UrlResource(filePath.toUri());
            if (!resource.exists() || !resource.isReadable()) {
                logger.error("다운로드 요청 실패: 파일을 찾을 수 없거나 읽을 수 없음. 경로: {}", filePath);
                // 실제 배포 환경에서는 이 부분에서 더 구체적인 예외 처리가 필요할 수 있습니다.
                // 예를 들어, 파일을 찾을 수 없다는 메시지를 사용자에게 전달하는 커스텀 예외 페이지로 리다이렉트 등
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "요청한 파일을 찾을 수 없습니다.");
            }

            String originalFileName = post.getOriginalFileName();
            if (originalFileName == null || originalFileName.isEmpty()) {
                originalFileName = post.getFileName();
            }

            String encodedDownloadName = new String(originalFileName.getBytes("UTF-8"), "ISO-8859-1");

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedDownloadName + "\"")
                    .contentType(determineMediaType(filePath))
                    .body(resource);

        } catch (MalformedURLException e) {
            logger.error("다운로드 URL 생성 오류: {}", filePath, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } catch (UnsupportedEncodingException e) {
            logger.error("파일명 인코딩 오류: {}", post.getOriginalFileName(), e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } catch (ResponseStatusException e) { // ResponseStatusException을 명시적으로 캐치
            throw e; // 그대로 다시 던져서 Spring이 처리하도록 함
        } catch (IOException e) {
            logger.error("파일 처리 오류 (download): {}", filePath, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    private org.springframework.http.MediaType determineMediaType(Path path) throws IOException {
        String contentType = Files.probeContentType(path);
        if (contentType == null) {
            return org.springframework.http.MediaType.APPLICATION_OCTET_STREAM;
        }
        return org.springframework.http.MediaType.parseMediaType(contentType);
    }

    /**
     * 지정된 파일 이름의 이미지를 웹 애플리케이션 내부 업로드 경로에서 찾아 반환합니다.
     * 이 엔드포인트는 <img src="..."> 태그 등을 통해 이미지를 직접 표시할 때 사용될 수 있습니다.
     *
     * @param filename 요청된 이미지의 파일명 (UUID로 생성된 저장 파일명)
     * @return 이미지 리소스 또는 404/500 에러 응답
     */
    @GetMapping("/image/{filename:.+}") // 파일 확장자를 포함한 모든 문자열을 받도록 수정
    public ResponseEntity<Resource> showImage(@PathVariable String filename) {
        // 파일 이름에 경로 조작 문자(.., /)가 있는지 확인하여 간단한 보안 처리
        if (filename.contains("..") || filename.contains("/") || filename.contains("\\")) {
            logger.warn("잘못된 파일 이름 요청: {}", filename);
            return ResponseEntity.badRequest().build();
        }

        String uploadPath = getUploadPath(); // 일관된 업로드 경로 사용
        try {
            Path filePath = Paths.get(uploadPath).resolve(filename).normalize();
            Resource resource = new UrlResource(filePath.toUri());

            if (!resource.exists() || !resource.isReadable()) {
                logger.warn("요청된 이미지를 찾을 수 없음: {}", filePath);
                return ResponseEntity.notFound().build();
            }

            String contentType = Files.probeContentType(filePath);
            if (contentType == null) {
                contentType = "application/octet-stream"; // 타입을 알 수 없는 경우 기본값
            }

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_TYPE, contentType)
                    .body(resource);

        } catch (MalformedURLException e) {
            logger.error("이미지 URL 생성 오류: {}", filename, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } catch (IOException e) {
            logger.error("이미지 파일 접근 오류: {}", filename, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // uploadPathByOS() 메서드는 더 이상 사용하지 않으므로 삭제 또는 주석 처리합니다.
    /*
     * public String uploadPathByOS() {
     * // ... (이전 OS별 경로 로직) ...
     * }
     */
}