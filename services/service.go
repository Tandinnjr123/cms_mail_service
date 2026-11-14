package services

import "cms_mail_service/model"

type Services interface {
	FetchEmailLog(offset, limit int) ([]model.EmailLog, error)
	SendMail(mailData model.MailInput) error
}
