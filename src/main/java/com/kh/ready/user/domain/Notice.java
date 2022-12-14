package com.kh.ready.user.domain;

import java.sql.Date;
import java.sql.Timestamp;

public class Notice {
	private Integer noticeNumber;
	private String noticeTitle;
	private String noticeContents;
	private String noticeWriter;
	private Timestamp postDate;
	
	public Notice(Integer noticeNumber, String noticeTitle, String noticeContents, String noticeWriter, Timestamp postDate) {
		super();
		this.noticeNumber = noticeNumber;
		this.noticeTitle = noticeTitle;
		this.noticeContents = noticeContents;
		this.noticeWriter = noticeWriter;
		this.postDate = postDate;
	}
	public Integer getNoticeNumber() {
		return noticeNumber;
	}
	public void setNoticeNumber(Integer noticeNumber) {
		this.noticeNumber = noticeNumber;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContents() {
		return noticeContents;
	}
	public void setNoticeContents(String noticeContents) {
		this.noticeContents = noticeContents;
	}
	public Timestamp getPostDate() {
		return postDate;
	}
	public void setPostDate(Timestamp postDate) {
		this.postDate = postDate;
	}
	
	public String getNoticeWriter() {
		return noticeWriter;
	}
	public void setNoticeWriter(String noticeWriter) {
		this.noticeWriter = noticeWriter;
	}
	@Override
	public String toString() {
		return "Notice [noticeNumber=" + noticeNumber + ", noticeTitle=" + noticeTitle + ", noticeContents="
				+ noticeContents + ", noticeWriter=" + noticeWriter + ", postDate=" + postDate + "]";
	}
	
	
	
	
	
}
