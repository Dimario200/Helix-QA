﻿#language: ru
@tree

Функционал: Проверка возвратов (OperationType) LifePay

Фискальный регистратор: 'LifePay - онлайн фискализация в ОФД (54-ФЗ)'
Версия ФФД: "1,2"

//Комментарий на проверку xml:
//Убрал проверку supplier_name (организация) и supplier_inn (кассир)
//ref_uuid всегда разный поэтому "*"

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Первоначальная настройка
	И я удаляю все переменные
	И Я создаю клиента lifepay
	И Я создаю Услуга_Персональная

Сценарий: Полный возврат
	И Остановка если была ошибка в прошлом сценарии

*Продажа
	Дано Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу значение переменной '$$КлиентLifePay$$'
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице "Запасы" из выпадающего списка с именем "ЗапасыНоменклатура" я выбираю по строке '$$УслугаПерсональная$$'
	И Я Оплатил документ через lifepay

*Возврат
	И я перехожу по навигационной ссылке "$$СсылкаКлиентаLifePay$$"
	И В текущем окне я нажимаю кнопку командного интерфейса 'Продажи'
	И я нажимаю на кнопку с именем 'СписокДокументВозвратОтПокупателяСоздатьНаОсновании'
	И я нажимаю на кнопку с именем 'ФормаОплатить'
	И я нажимаю на кнопку с именем 'КассаОплаты_2'
	И я активизирую окно "Возврат"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'

	И Проверка xml lifepay
	И элемент формы с именем 'ТекстXML' стал равен по шаблону
		| '{*'                                                 |
		| '\"apikey\": \"379b9878cf4973699a7aea7d37562a3f\",*' |
		| '\"login\": \"79882843969\",*'                       |
		| '\"purchase\": {*'                                   |
		| '\"products\": [*'                                   |
		| '{*'                                                 |
		| '\"name\": \" $$УслугаПерсональная$$\",*'            |
		| '\"price\": 250,*'                                   |
		| '\"quantity\": 1,*'                                  |
		| '\"tax\": \"none\",*'                                |
		| '\"type\": \"4\",*'                                  |
		| '\"item_type\": \"4\",*'                             |
		| '\"measurement_unit\": 0*'                           |
		| '}*'                                                 |
		| ']*'                                                 |
		| '},*'                                                |
		| '\"mode\": \"email\",*'                              |
		| '\"type\": \"refund\",*'                             |
		| '\"source\": \"1С_cloud\",*'                         |
		| '\"customer_phone\": \"+*\",*'                       |
		| '\"cash_amount\": 250,*'                             |
		| '\"card_amount\": 0,*'                               |
		| '\"prepayment_amount\": 0,*'                         |
		| '\"credit_amount\": 0,*'                             |
		| '\"other_amount\": 0,*'                              |
		| '\"cashier_name\": \"*\",*'                          |
		| '\"supplier_name\": \"*\",*'                         |
		| '\"supplier_inn\": \"*\",*'                          |
		| '\"tax_system\": \"osn\",*'                          |
		| '\"target_serial\": \"00106701076650\",*'            |
		| '\"ref_uuid\": \"*\"*'                               |
		| '}'                                                  |

Сценарий: Частичный возврат номенклатуры
*Продажа
	Дано Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу значение переменной '$$КлиентLifePay$$'
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице "Запасы" из выпадающего списка с именем "ЗапасыНоменклатура" я выбираю по строке '$$УслугаПерсональная$$'
	И Я Оплатил документ через lifepay

*Возврат
	И я перехожу по навигационной ссылке "$$СсылкаКлиентаLifePay$$"
	И В текущем окне я нажимаю кнопку командного интерфейса 'Продажи'
	И я нажимаю на кнопку с именем 'СписокДокументВозвратОтПокупателяСоздатьНаОсновании'
	И в таблице "Запасы" я активизирую поле с именем "ЗапасыКоличествоУпаковок"
	И в таблице "Запасы" в поле с именем 'ЗапасыКоличествоУпаковок' я ввожу текст '0,1'
	И в таблице "Запасы" я завершаю редактирование строки
	И я нажимаю на кнопку с именем 'ФормаОплатить'
	И я нажимаю на кнопку с именем 'КассаОплаты_2'
	И я активизирую окно "Возврат"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'

	И Проверка xml lifepay
	И элемент формы с именем 'ТекстXML' стал равен по шаблону
		| '{*'                                                 |
		| '\"apikey\": \"379b9878cf4973699a7aea7d37562a3f\",*' |
		| '\"login\": \"79882843969\",*'                       |
		| '\"purchase\": {*'                                   |
		| '\"products\": [*'                                   |
		| '{*'                                                 |
		| '\"name\": \" $$УслугаПерсональная$$\",*'            |
		| '\"price\": 250,*'                                   |
		| '\"quantity\": 0.1,*'                                |
		| '\"tax\": \"none\",*'                                |
		| '\"type\": \"4\",*'                                  |
		| '\"item_type\": \"4\",*'                             |
		| '\"measurement_unit\": 0*'                           |
		| '}*'                                                 |
		| ']*'                                                 |
		| '},*'                                                |
		| '\"mode\": \"email\",*'                              |
		| '\"type\": \"refund\",*'                             |
		| '\"source\": \"1С_cloud\",*'                         |
		| '\"customer_phone\": \"+*\",*'                       |
		| '\"cash_amount\": 25,*'                              |
		| '\"card_amount\": 0,*'                               |
		| '\"prepayment_amount\": 0,*'                         |
		| '\"credit_amount\": 0,*'                             |
		| '\"other_amount\": 0,*'                              |
		| '\"cashier_name\": \"*\",*'                          |
		| '\"supplier_name\": \"О*\",*'                        |
		| '\"supplier_inn\": \"*\",*'                          |
		| '\"tax_system\": \"osn\",*'                          |
		| '\"target_serial\": \"00106701076650\",*'            |
		| '\"ref_uuid\": \"*\"*'                               |
		| '}'                                                  |

Сценарий: Дальнейший возврат номенклатуры
	И предыдущий сценарий выполнен успешно
	
*Возврат
	И я перехожу по навигационной ссылке "$$СсылкаКлиентаLifePay$$"
	И В текущем окне я нажимаю кнопку командного интерфейса 'Продажи'
	И я нажимаю на кнопку с именем 'СписокДокументВозвратОтПокупателяСоздатьНаОсновании'
	И я нажимаю на кнопку с именем 'ФормаОплатить'
	И я нажимаю на кнопку с именем 'КассаОплаты_2'
	И я активизирую окно "Возврат"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'

	И Проверка xml lifepay
	И элемент формы с именем 'ТекстXML' стал равен по шаблону
		| '{*'                                                 |
		| '\"apikey\": \"379b9878cf4973699a7aea7d37562a3f\",*' |
		| '\"login\": \"79882843969\",*'                       |
		| '\"purchase\": {*'                                   |
		| '\"products\": [*'                                   |
		| '{*'                                                 |
		| '\"name\": \" $$УслугаПерсональная$$\",*'            |
		| '\"price\": 250,*'                                   |
		| '\"quantity\": 0.9,*'                                |
		| '\"tax\": \"none\",*'                                |
		| '\"type\": \"4\",*'                                  |
		| '\"item_type\": \"4\",*'                             |
		| '\"measurement_unit\": 0*'                           |
		| '}*'                                                 |
		| ']*'                                                 |
		| '},*'                                                |
		| '\"mode\": \"email\",*'                              |
		| '\"type\": \"refund\",*'                             |
		| '\"source\": \"1С_cloud\",*'                         |
		| '\"customer_phone\": \"+*\",*'                       |
		| '\"cash_amount\": 225,*'                             |
		| '\"card_amount\": 0,*'                               |
		| '\"prepayment_amount\": 0,*'                         |
		| '\"credit_amount\": 0,*'                             |
		| '\"other_amount\": 0,*'                              |
		| '\"cashier_name\": \"*\",*'                          |
		| '\"supplier_name\": \"*\",*'                         |
		| '\"supplier_inn\": \"*\",*'                          |
		| '\"tax_system\": \"osn\",*'                          |
		| '\"target_serial\": \"00106701076650\",*'            |
		| '\"ref_uuid\": \"*\"*'                               |
		| '}'                                                  |
СсылкаКлиентаLifePay
Сценарий: Частичный возврат средств
*Продажа
	Дано Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу значение переменной '$$КлиентLifePay$$'
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице "Запасы" из выпадающего списка с именем "ЗапасыНоменклатура" я выбираю по строке '$$УслугаПерсональная$$'
	И Я Оплатил документ через lifepay

*Возврат
	И я перехожу по навигационной ссылке "$$СсылкаКлиентаLifePay$$"
	И В текущем окне я нажимаю кнопку командного интерфейса 'Продажи'
	И я нажимаю на кнопку с именем 'СписокДокументВозвратОтПокупателяСоздатьНаОсновании'
	И я нажимаю на кнопку с именем 'ФормаОплатить'
	И я нажимаю на кнопку с именем 'КассаОплаты_2'
	И я активизирую окно "Возврат"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст '200,00'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'
	И я нажимаю на кнопку с именем 'Button0'

	И Проверка xml lifepay
	И элемент формы с именем 'ТекстXML' стал равен по шаблону
		| '{*'                                                 |
		| '\"apikey\": \"379b9878cf4973699a7aea7d37562a3f\",*' |
		| '\"login\": \"79882843969\",*'                       |
		| '\"purchase\": {*'                                   |
		| '\"products\": [*'                                   |
		| '{*'                                                 |
		| '\"name\": \" $$УслугаПерсональная$$\",*'            |
		| '\"price\": 250,*'                                   |
		| '\"quantity\": 1,*'                                  |
		| '\"tax\": \"none\",*'                                |
		| '\"type\": \"5\",*'                                  |
		| '\"item_type\": \"4\",*'                             |
		| '\"measurement_unit\": 0*'                           |
		| '}*'                                                 |
		| ']*'                                                 |
		| '},*'                                                |
		| '\"mode\": \"email\",*'                              |
		| '\"type\": \"refund\",*'                             |
		| '\"source\": \"1С_cloud\",*'                         |
		| '\"customer_phone\": \"+*\",*'                       |
		| '\"cash_amount\": 200,*'                             |
		| '\"card_amount\": 0,*'                               |
		| '\"prepayment_amount\": 0,*'                         |
		| '\"credit_amount\": 50,*'                            |
		| '\"other_amount\": 0,*'                              |
		| '\"cashier_name\": \"*\",*'                          |
		| '\"supplier_name\": \"*\",*'                         |
		| '\"supplier_inn\": \"*\",*'                          |
		| '\"tax_system\": \"osn\",*'                          |
		| '\"target_serial\": \"00106701076650\",*'            |
		| '\"ref_uuid\": \"*\"*'                               |
		| '}'                                                  |

Сценарий: Отмена ошибочной оплаты
*Оплата
	Дано Я открываю основную форму документа "Реализация"
	И в поле с именем 'Контрагент' я ввожу значение переменной '$$КлиентLifePay$$'
	И я нажимаю на кнопку с именем 'ЗапасыКнопкаДобавить'
	И в таблице "Запасы" из выпадающего списка с именем "ЗапасыНоменклатура" я выбираю по строке '$$УслугаПерсональная$$'
	И Я Оплатил документ через lifepay

*Отмена ошибочной оплаты
	Дано Я открываю навигационную ссылку "$$СсылкаКлиентаLifePay$$"
	И В текущем окне я нажимаю кнопку командного интерфейса 'Продажи'
	И я нажимаю на кнопку с именем 'ФормаОтменаОплаты'
	И я нажимаю на кнопку с именем 'КомандаВыполнить'
	И я нажимаю на кнопку с именем 'Button0'

	И Проверка xml lifepay
	И элемент формы с именем 'ТекстXML' стал равен по шаблону
		| '{*'                                                 |
		| '\"apikey\": \"379b9878cf4973699a7aea7d37562a3f\",*' |
		| '\"login\": \"79882843969\",*'                       |
		| '\"purchase\": {*'                                   |
		| '\"products\": [*'                                   |
		| '{*'                                                 |
		| '\"name\": \" $$УслугаПерсональная$$\",*'            |
		| '\"price\": 250,*'                                   |
		| '\"quantity\": 1,*'                                  |
		| '\"tax\": \"none\",*'                                |
		| '\"type\": \"4\",*'                                  |
		| '\"item_type\": \"4\",*'                             |
		| '\"measurement_unit\": 0*'                           |
		| '}*'                                                 |
		| ']*'                                                 |
		| '},*'                                                |
		| '\"mode\": \"print\",*'                              |
		| '\"type\": \"refund\",*'                             |
		| '\"source\": \"1С_cloud\",*'                         |
		| '\"cash_amount\": 250,*'                             |
		| '\"card_amount\": 0,*'                               |
		| '\"prepayment_amount\": 0,*'                         |
		| '\"credit_amount\": 0,*'                             |
		| '\"other_amount\": 0,*'                              |
		| '\"cashier_name\": \"*\",*'                          |
		| '\"supplier_name\": \"*\",*'                         |
		| '\"supplier_inn\": \"*\",*'                          |
		| '\"tax_system\": \"osn\",*'                          |
		| '\"target_serial\": \"00106701076650\",*'            |
		| '\"ref_uuid\": \"*\"*'                               |
		| '}'                                                  |

Сценарий: OperationType-2 (Отмена ошибочной оплаты, частичная оплата)
*Оплата
	Дано Я открываю навигационную ссылку "$$СсылкаКлиентаLifePay$$"
	И В текущем окне я нажимаю кнопку командного интерфейса 'Продажи'
	И я нажимаю на кнопку с именем 'СписокОплатить'
	И я нажимаю на кнопку с именем 'КассаОплаты_2'
	И я активизирую окно "Оплата"
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатаНаименованиеСтрока_0'
	И в поле с именем 'ПолеВидыОплатВводСуммыСтрока_0' я ввожу текст '200,00'
	И я нажимаю на кнопку с именем 'КнопкаВидыОплатПрименитьеСуммуСтрока_0'
	И я нажимаю на кнопку с именем 'Оплатить'
	И я нажимаю на кнопку с именем 'Button0'	

*Отмена
	И я нажимаю на кнопку с именем 'ФормаОтменаОплаты'
	И я нажимаю на кнопку с именем 'КомандаВыполнить'
	И я нажимаю на кнопку с именем 'Button0'

	И Проверка xml lifepay
	И элемент формы с именем 'ТекстXML' стал равен по шаблону
		| '{*'                                                 |
		| '\"apikey\": \"379b9878cf4973699a7aea7d37562a3f\",*' |
		| '\"login\": \"79882843969\",*'                       |
		| '\"purchase\": {*'                                   |
		| '\"products\": [*'                                   |
		| '{*'                                                 |
		| '\"name\": \" $$УслугаПерсональная$$\",*'            |
		| '\"price\": 250,*'                                   |
		| '\"quantity\": 1,*'                                  |
		| '\"tax\": \"none\",*'                                |
		| '\"type\": \"5\",*'                                  |
		| '\"item_type\": \"4\",*'                             |
		| '\"measurement_unit\": 0*'                           |
		| '}*'                                                 |
		| ']*'                                                 |
		| '},*'                                                |
		| '\"mode\": \"email\",*'                              |
		| '\"type\": \"payment\",*'                            |
		| '\"source\": \"1С_cloud\",*'                         |
		| '\"customer_phone\": \"+*\",*'                       |
		| '\"cash_amount\": 200,*'                             |
		| '\"card_amount\": 0,*'                               |
		| '\"prepayment_amount\": 0,*'                         |
		| '\"credit_amount\": 50,*'                            |
		| '\"other_amount\": 0,*'                              |
		| '\"cashier_name\": \"*\",*'                          |
		| '\"supplier_name\": \"*\",*'                         |
		| '\"supplier_inn\": \"*\",*'                          |
		| '\"tax_system\": \"osn\",*'                          |
		| '\"target_serial\": \"00106701076650\"*'             |
		| '}'                                                  |