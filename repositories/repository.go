package repositories

import "cms_mail_service/model"

type Repository interface {
	FetchEmailLog(offset, limit int) ([]model.EmailLog, error)
	SendMail(mailData model.MailInput) error
}