
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import subprocess
from val import PASSWORD_GOOGLE


commit_hash = subprocess.check_output(['git', 'rev-parse', 'HEAD']).decode().strip()

passwd = PASSWORD_GOOGLE
#passwd = os.getenv('PASSWORD_GOOGLE')


smtp_server = "smtp.gmail.com"
smtp_port = 587
smtp_username = "sorok.arterg@gmail.com"
smtp_password = passwd


sender = "sorok.arterg@gmail.com"
receiver = "sorokin-arterg@yandex.ru"
subject = "New commit created"
message = f"A new commit has been created with the hash: {commit_hash}"

msg = MIMEMultipart()
msg['From'] = sender
msg['To'] = receiver
msg['Subject'] = subject
msg.attach(MIMEText(message, 'plain'))


try:
    with smtplib.SMTP(smtp_server, smtp_port) as server:
        server.starttls()
        server.login(smtp_username, smtp_password)
        server.send_message(msg)
    print('Success')
except Exception as e:
    print('Error : ', str(e))
