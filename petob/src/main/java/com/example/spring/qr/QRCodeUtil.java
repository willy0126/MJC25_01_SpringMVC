package com.example.spring.qr;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.client.j2se.MatrixToImageWriter;

import java.io.File;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class QRCodeUtil {

    public static String createQRImage(String text, String uploadPath) throws Exception {
        int width = 200;
        int height = 200;

        String fileName = UUID.randomUUID().toString() + "_qrcode.png";
        String fullPath = uploadPath + fileName;

        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");

        BitMatrix bitMatrix = new MultiFormatWriter().encode(text, BarcodeFormat.QR_CODE, width, height, hints);
        Path path = new File(fullPath).toPath();
        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);

        return "/resources/uploads/" + fileName;
    }
}

