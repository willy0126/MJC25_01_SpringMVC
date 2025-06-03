package com.example.spring.notice;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {

    // 임시 저장소 역할 (DB 연동 전까지는 메모리 기반으로 사용 가능)
    private final List<NoticeDto> noticeList = new ArrayList<>();
    private Long nextId = 1L;

    @Override
    public List<NoticeDto> getAllNotices() {
        return new ArrayList<>(noticeList);
    }

    @Override
    public NoticeDto getNoticeById(Long id) {
        return noticeList.stream()
                .filter(notice -> notice.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    @Override
    public boolean createNotice(NoticeDto noticeDto) {
        noticeDto.setId(nextId++);
        noticeList.add(noticeDto);
        return true;
    }

    @Override
    public boolean updateNotice(NoticeDto noticeDto) {
        for (int i = 0; i < noticeList.size(); i++) {
            if (noticeList.get(i).getId().equals(noticeDto.getId())) {
                noticeList.set(i, noticeDto);
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean deleteNotice(Long id) {
        return noticeList.removeIf(notice -> notice.getId().equals(id));
    }

    @Override
    public int getTotalNoticeCount() {
        return noticeList.size();
    }

    @Override
    public List<NoticeDto> searchNoticesByTitle(String title) {
        List<NoticeDto> result = new ArrayList<>();
        for (NoticeDto notice : noticeList) {
            if (notice.getTitle() != null && notice.getTitle().contains(title)) {
                result.add(notice);
            }
        }
        return result;
    }

    @Override
    public boolean validateNotice(NoticeDto noticeDto) {
        return noticeDto != null &&
               noticeDto.getTitle() != null && !noticeDto.getTitle().trim().isEmpty() &&
               noticeDto.getContent() != null && !noticeDto.getContent().trim().isEmpty();
    }
}
