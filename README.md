# Проектная работа “Реализация процедуры ETL”

## Техническое задание:  
* Создать таблицы измерений и таблицу фактов в PostreSQL.   
* Наполнить базу данными из бд bookings при помощи ETL.  

Требуемые таблицы:  
* Fact_Flights - содержит совершенные перелеты. Если в рамках билета был сложный маршрут с пересадками - каждый сегмент учитываем независимо  
  * Пассажир  
  * Дата и время вылета (факт)  
  * Дата и время прилета (факт)  
  * Задержка вылета (разница между фактической и запланированной датой в секундах)  
  * Задержка прилета (разница между фактической и запланированной датой в секундах)  
  * Самолет  
  * Аэропорт вылета  
  * Аэропорт прилета  
  * Класс обслуживания  
  * Стоимость  
* Dim_Calendar - справочник дат  
* Dim_Passengers - справочник пассажиров  
* Dim_Aircrafts - справочник самолетов  
* Dim_Airports - справочник аэропортов  
* Dim_Tariff - справочник тарифов (Эконом/бизнес и тд)  

## Запуск проекта:

1. Установить Pentaho 9.3 ( https://sourceforge.net/projects/pentaho/files/Pentaho-9.3/client-tools/pdi-ce-9.3.0.0-428.zip/download ) и java 8 (https://www.oracle.com/java/technologies/downloads/#java8 ).  
2. Восстановить базу данных DB_dwh_demo_nj из файла _DB_dwh_demo_nj.sql_ *  или выполнить скрипт _Create_table__FW_DWH_2023.sql_  - создать базу, схемы и все таблицы.  
3. Найти файл kettle.properties  и прописать в параметр OUT_DIR путь к папке с трансформациями (Transformations).  
4. Запустить _start_bookings_FW_DWH_2023.kjb_ . 

Для проверки работы фильтров необходимо восстановить shema_bookings_with_error.sql* .

_\* Backup базы данных и схем можно скачать по ссылке https://disk.yandex.ru/d/EOYUW_8uxHw6vA_ .

## Папки репозитория:

### Documentation:

* _2023_03_17_Documentation_FW_DWH_bookings_Lezhneva.pdf_ документация по проекту.

### Screenshots:

* #### ER_Diagram:
  * _ER_diagram_dwh_bookings.png_ - ER диаграмма таблиц измерений и таблицы фактов;
  * _ER_diagram_dwh_bookings_reject.png_ - ER диаграмма таблиц для некачественных данных.
* #### screen_jobs: 
  * _start_bookings_FW_DWH_2023.png_ - скриншот задания.
* #### screen_tramsformation:
  * _dim_aircrafts.png_ - скриншот трансформации по загрузке данных в таблицу измерения dim_aircrafts;
  * _dim_airports.png_ - скриншот трансформации по загрузке данных в таблицу измерения _dim_airports;
  * _dim_passengers.png_ - скриншот трансформации по загрузке данных в таблицу измерения _dim_passengers;
  * _dim_tariff.png_ - скриншот трансформации по загрузке данных в таблицу измерения _dim_tariff;
  * _fact_flights.png_ - скриншот трансформации по загрузке данных в таблицу фактов _fact_flights.
  
### SQL:

* _Create_table__FW_DWH_2023.sql_ - скрипт по созданию таблиц измерений и таблицы фактов, reject-таблиц для некачесвенных данных в схемах dwh_bookings и dwh_bookings_reject:
* _Drop_table_FW_DWH_2023.sql_ - скрипт для удаления таблиц измерений, таблицы фактов, reject-таблиц из  схем dwh_bookings и dwh_bookings_reject;
* _Select_table_FW_DWH_2023.sql_ - sql запросы к различным таблицам базы данных DB_dwh_demo_nj.

### Transformations:

* _dim_aircrafts.ktr_ - файл с трансформацией dim_aircrafts;
* _dim_airoports.ktr_ - файл с трансформацией dim_airoports;
* _dim_passengers.ktr_ - файл с трансформацией dim_passengers;
* _dim_tariff.ktr_ - файл с трансформацией dim_tariff;
* _fact_flights.ktr_ - файл с трансформацией fact_flights;
* _start_bookings_FW_DWH_2023.kjb_ - файл с заданием.
