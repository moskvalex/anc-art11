Набор скриптов для парсинга документов Autoritatea Națională pentru Cetățenie.
Скрипты формируют SQLite-базу для анализа и других статистических целей.

# Подготовка к работе:
#Клонирование репозитория <br />
**git clone https://github.com/moskvalex/anc-art11.git** <br />
#Скачиваем архив документов ANC (satadiu+dosar) и формируем базу данных <br />
**./_prepare.sh** <br />
#Устанавливаем зависимости <br />
**pip3 install -r requirements.txt** <br />

# Назначение скриптов:
**parse_stadiu.py** - скрипт формирует начальную базу на основе парсинга документов в директории stadiu/pub/. При пустой базе данных, этот скрипт необходимо запускать в первую очередь. <br />
**get_ordins.py** - пополнение архива документов. С сайта ANC загружаются и сохраняются приказы о присвоении гражданства, которые отсутствуют в директории ordins. <br />
**parse_ordins.py** - Парсинг приказов. Скрипт проходит по всем приказам и корректирует базу данных по делам, попавшим в приказы. <br />


# Структура БД:

Таблица Dosar
- id TEXT - номер дела в формате <номер>/RD/<год>
- year INTEGER - год подачи
- number INTEGER - номер дела
- depun DATA - дата подачи документов
- solutie DATE DEFAULT NULL - дата решения по делу, или NULL, если решение ещё не принято
- ordin TEXT - номер приказа о гражданстве, по которому принято решение
- result INTEGER DEFAULT NULL - результат рассмотрения дела. 0/False == отказ, 1/True == положительное решение, NULL - решение ещё не принято
- termen DATE DEFAULT NULL - последняя известная дата проведения комиссии по делу
- suplimentar INTEGER DEFAULT False - был ли дозапрос документов по данному делу

Таблица Termen
 - id TEXT - номер дела в формате <номер>/RD/<год>
 - termen DATE - назначенная дата рассмотрения дела.
 - stadiu DATE - дата stadiu, в котором изменился Termen
Эта таблица создаётся с правилом UNIQUE(id, termen), которое принудительно сохраняет только уникальные пары id+termen.