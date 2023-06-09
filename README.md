<h1 align="center">Restart1cAgent</h1>
<p align="left"> <img src="https://komarev.com/ghpvc/?username=tsarbom4&label=Profile%20views&color=0e75b6&style=flat" alt="tsarbom4" /> </p>

Данный скрипт на PowerShell позволяет перезапускать службу 1С:Предприятия 8.3 (x86-64) на сервере и при необходимости очищать кеш.

<h1 align="center">Некоторые возможности скрипта:</h1>

Параметризация: скрипт имеет возможность настройки параметров, таких как название службы, путь сохранения файла лога, размер файла лога, необходимость очистки кеша и директория, в которой находится кеш.
Проверка статуса службы: перед остановкой и запуском службы, скрипт проверяет ее статус и повторяет попытки остановки/запуска, если статус не соответствует нужному.
Логирование: скрипт пишет информацию о своей работе в файл лога, который сохраняется по указанному пути. Старые файлы логов автоматически удаляются, если их возраст больше, чем указанное количество дней.
Обработка ошибок: в случае возникновения ошибок при выполнении скрипта, они записываются в файл лога и выводятся на консоль с пометкой "ERROR".
Гибкая настройка скрипта позволяет адаптировать его под конкретные нужды и ситуации. Например, можно изменить название службы на другое, указать другой путь для сохранения файла лога, изменить размер файла лога и т.д.

<h1 align="center">Настройка скрипта:</h1>

Для настройки скрипта на Powershell необходимо изменить значения переменных в начале скрипта, которые соответствуют вашей конфигурации. Ниже приведено описание этих переменных:

* $1CServiceName - имя службы 1С, которую вы хотите перезапустить
* $logFilePath - путь к файлу логов скрипта
* $logFileSizeInBytes - максимальный размер файла логов в байтах
* $clearCache - флаг, указывающий, нужно ли очистить кеш после остановки службы (1 - очистить, 0 - не очищать)
* $pathCache - путь к директории, где находится кеш кластера 1С
Чтобы начать работу со скриптом, сохраните его в файл с расширением .ps1, например, "restart_1c_service.ps1". Запустите PowerShell, перейдите в папку, где находится скрипт, и выполните команду .\restart_1c_service.ps1. Скрипт начнет выполнение и выведет результаты в консоль и в файл логов, указанный в $logFilePath.

Чтобы добавить скрипт в планировщик задач Windows, следуйте этим шагам:

* Откройте Планировщик задач Windows
* Создайте новую задачу
* Укажите имя и описание задачи
* На странице "Триггеры" добавьте новый триггер и укажите расписание выполнения задачи (например, ежедневно в 01:00)
* На странице "Действия" добавьте новое действие и выберите "Начать программу"
* В поле "Программа" укажите путь к исполняемому файлу PowerShell (C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe)
* В поле "Аргументы" укажите путь к скрипту (-File "C:\path\to\restart_1c_service.ps1")
* Нажмите "ОК", чтобы сохранить задачу
* Теперь задача будет выполняться по указанному расписанию, и служба 1С будет перезапускаться автоматически.
