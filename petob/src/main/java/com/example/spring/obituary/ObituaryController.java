// 📁 ObituaryController.java
package com.example.spring.obituary;

import com.example.spring.qr.QRCodeUtil;
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

    @GetMapping("/info/obituary")
    public String showObituaryForm() {
        return "obituary";
    }

    @PostMapping("/obituary/submit")
    public String submitObituary(@ModelAttribute ObituaryDto dto,
                                 @RequestParam("photo") MultipartFile photoFile,
                                 HttpServletRequest request,
                                 Model model) {

        // 업로드 경로 (톰캣 기준)
        String realPath = request.getServletContext().getRealPath("/resources/uploads/");
        File uploadDir = new File(realPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

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

        obituaryService.insertObituary(dto);
        ObituaryDto latest = obituaryService.selectLatestObituary();
        model.addAttribute("obituary", latest);

        return "obituary_result";
    }

    @GetMapping("/obituary/qrcode")
    public String generateQRCode(HttpServletRequest request, Model model) {
        ObituaryDto dto = obituaryService.selectLatestObituary();

        try {
            String realPath = request.getServletContext().getRealPath("/resources/uploads/");
            String url = "http://localhost:8080/obituary/submit"; // 필요 시 실제 URL 수정

            String qrPath = QRCodeUtil.createQRImage(url, realPath);
            model.addAttribute("qrCodePath", qrPath);
            model.addAttribute("obituary", dto);

        } catch (Exception e) {
            model.addAttribute("errorMessage", "QR 코드 생성 실패: " + e.getMessage());
            model.addAttribute("obituary", dto);
        }

        return "obituary_result";
    }
}


