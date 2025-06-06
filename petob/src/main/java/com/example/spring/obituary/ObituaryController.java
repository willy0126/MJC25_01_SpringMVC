package com.example.spring.obituary;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Controller
public class ObituaryController {

    @Autowired
    private ObituaryService obituaryService;

    // 부고장 작성 폼 페이지
    @GetMapping("/info/obituary")
    public String showObituaryForm() {
        return "obituary";
    }

    // 부고장 제출 처리
    @PostMapping("/obituary/submit")
    public String submitObituary(@ModelAttribute ObituaryDto dto,
                                 @RequestParam("photo") MultipartFile photoFile,
                                 HttpServletRequest request,
                                 Model model) {

        // 파일 업로드 경로 설정
        String realPath = request.getServletContext().getRealPath("/resources/uploads/");
        File uploadDir = new File(realPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // 파일 저장 처리
        if (!photoFile.isEmpty()) {
            try {
                String fileName = UUID.randomUUID() + "_" + photoFile.getOriginalFilename();
                File dest = new File(realPath, fileName);
                photoFile.transferTo(dest);
                dto.setPhotoPath("/resources/uploads/" + fileName);
            } catch (IOException e) {
                model.addAttribute("errorMessage", "사진 업로드 실패: " + e.getMessage());
                return "obituary";
            }
        }

        // DB에 저장 + 최신 부고장 가져오기
        obituaryService.insertObituary(dto);
        ObituaryDto latest = obituaryService.selectLatestObituary();
        model.addAttribute("obituary", latest);

        return "obituary_result";
    }
}



