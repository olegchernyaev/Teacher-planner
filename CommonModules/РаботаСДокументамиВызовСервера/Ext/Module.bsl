﻿
Процедура НайтиИОтменитьПодтверждениеПроведенияИОплаты(ЗанятиеСсылка) Экспорт
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	ОплатаЗанятий.Регистратор
	                      |ИЗ
	                      |	РегистрНакопления.ОплатаЗанятий КАК ОплатаЗанятий
	                      |ГДЕ
	                      |	ОплатаЗанятий.Регистратор.Занятие = &Занятие
	                      |
	                      |ОБЪЕДИНИТЬ ВСЕ
	                      |
	                      |ВЫБРАТЬ
	                      |	Продажи.Регистратор
	                      |ИЗ
	                      |	РегистрНакопления.Продажи КАК Продажи
	                      |ГДЕ
	                      |	Продажи.Регистратор.Занятие = &Занятие");
	Запрос.УстановитьПараметр("Занятие", ЗанятиеСсылка);
	Результат = Запрос.Выполнить().Выбрать();
	Пока Результат.Следующий() Цикл
		Док = Результат.Регистратор.ПолучитьОбъект();
		Док.УстановитьПометкуУдаления(Истина);
	КонецЦикла;;
	
	СтатусЗанятия = ПредопределенноеЗначение("Перечисление.СтатусыЗанятий.Отменено");		
	
КонецПроцедуры

Функция ЕстьОплатаЗанятия(ЗанятиеСсылка) Экспорт
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	ОплатаЗанятий.Регистратор
	                      |ИЗ
	                      |	РегистрНакопления.ОплатаЗанятий КАК ОплатаЗанятий
	                      |ГДЕ
	                      |	ОплатаЗанятий.Регистратор.Занятие = &Занятие");
	Запрос.УстановитьПараметр("Занятие", ЗанятиеСсылка);
	Результат = Запрос.Выполнить().Выбрать();
	Если Результат.Следующий() Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

Процедура ЗаписатьСтатусЗанятия(ЗанятиеСсылка, СтатусЗанятия) Экспорт
	РегистрыСведений.СтатусыЗанятий.ЗаписатьСтатусЗанятия(ЗанятиеСсылка, СтатусЗанятия);
КонецПроцедуры

Процедура СменитьСтатусЗанятия(ЗанятиеСсылка, СтатусЗанятия) Экспорт
	
	Если СтатусЗанятия = Перечисления.СтатусыЗанятий.Проведено Тогда
		
		Если НайтиПодтверждениеПроведения(ЗанятиеСсылка) Тогда		
			Возврат;
		Иначе
			СоздатьПодтверждениеПроведения(ЗанятиеСсылка);
			
			Если ЗанятиеПроведеноИОплачено(ЗанятиеСсылка) Тогда
				СтатусЗанятия = Перечисления.СтатусыЗанятий.ПроведеноИОплачено;
			КонецЕсли;
			
			ЗаписатьСтатусЗанятия(ЗанятиеСсылка, СтатусЗанятия);
		КонецЕсли;
		
	ИначеЕсли СтатусЗанятия = Перечисления.СтатусыЗанятий.Подтверждено 
		ИЛИ СтатусЗанятия = Перечисления.СтатусыЗанятий.НеПодтверждено Тогда
		
		ЗаписатьСтатусЗанятия(ЗанятиеСсылка, СтатусЗанятия);
		НайтиИОтменитьПодтверждениеПроведенияИОплаты(ЗанятиеСсылка);
		
	ИначеЕсли СтатусЗанятия = Перечисления.СтатусыЗанятий.Оплачено Тогда
		
		Если НайтиПодтверждениеОплаты(ЗанятиеСсылка) Тогда 
			Возврат; 
		Иначе
			СоздатьПодтверждениеОплаты(ЗанятиеСсылка);
			
			Если ЗанятиеПроведеноИОплачено(ЗанятиеСсылка) Тогда
				СтатусЗанятия = Перечисления.СтатусыЗанятий.ПроведеноИОплачено;
			КонецЕсли;
			
			ЗаписатьСтатусЗанятия(ЗанятиеСсылка, СтатусЗанятия);			
		КонецЕсли;		
		
	ИначеЕсли СтатусЗанятия = Перечисления.СтатусыЗанятий.Отменено Тогда
		
		ЗаписатьСтатусЗанятия(ЗанятиеСсылка, СтатусЗанятия);
		НайтиИОтменитьПодтверждениеПроведенияИОплаты(ЗанятиеСсылка);
		
	ИначеЕсли СтатусЗанятия = Перечисления.СтатусыЗанятий.Перенесено Тогда
		
		ЗаписатьСтатусЗанятия(ЗанятиеСсылка, СтатусЗанятия);
		НайтиИОтменитьПодтверждениеПроведенияИОплаты(ЗанятиеСсылка);
		
	ИначеЕсли СтатусЗанятия = Перечисления.СтатусыЗанятий.ПроведеноИОплачено Тогда
		
		Если НЕ НайтиПодтверждениеПроведения(ЗанятиеСсылка) Тогда		
			СоздатьПодтверждениеПроведения(ЗанятиеСсылка);			
		КонецЕсли;
		
		Если НЕ НайтиПодтверждениеОплаты(ЗанятиеСсылка) Тогда 
			 СоздатьПодтверждениеОплаты(ЗанятиеСсылка);
		КонецЕсли;
		
			ЗаписатьСтатусЗанятия(ЗанятиеСсылка, СтатусЗанятия);
					
	КонецЕсли;
	
КонецПроцедуры

Процедура СоздатьНовоеЗанятиеПоИсходному(ЗанятиеСсылка, НоваяДата, ЕстьОплатаЗанятия) Экспорт
	
	ПеренесенноеЗанятие = ЗанятиеСсылка;
	
	НовоеЗанятие = Документы.Занятия.СоздатьДокумент();
	
	ЗаполнитьЗначенияСвойств(НовоеЗанятие, ПеренесенноеЗанятие,,"Номер, Дата");
	
	НовоеЗанятие.Дата = НоваяДата;
	НовоеЗанятие.Уроки.Загрузить(ПеренесенноеЗанятие.Уроки.Выгрузить());
	
	Для Каждого СтрЗанятие из НовоеЗанятие.Уроки Цикл
		СтрЗанятие.ДатаНачала = НоваяДата;
	КонецЦикла;
	
	НовоеЗанятие.Записать(РежимЗаписиДокумента.Проведение);
	
	Если ЕстьОплатаЗанятия Тогда
		СоздатьПодтверждениеОплаты(НовоеЗанятие.Ссылка);
		РегистрыСведений.СтатусыЗанятий.ЗаписатьСтатусЗанятия(НовоеЗанятие.Ссылка, Перечисления.СтатусыЗанятий.Оплачено);
	Иначе
		РегистрыСведений.СтатусыЗанятий.ЗаписатьСтатусЗанятия(НовоеЗанятие.Ссылка, Перечисления.СтатусыЗанятий.НеПодтверждено);
	КонецЕсли;
		
КонецПроцедуры

Функция ЗанятиеПроведеноИОплачено(ЗанятиеСсылка) Экспорт
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	ВЫБОР
	                      |		КОГДА ЕСТЬNULL(ОплатаЗанятий.Регистратор.Занятие, ЗНАЧЕНИЕ(Документ.Занятия.)) <> ЗНАЧЕНИЕ(Документ.Занятия.)
	                      |			ТОГДА ИСТИНА
	                      |		ИНАЧЕ ЛОЖЬ
	                      |	КОНЕЦ КАК ЕстьОплата,
	                      |	ВЫБОР
	                      |		КОГДА ЕСТЬNULL(Продажи.Регистратор.Занятие, ЗНАЧЕНИЕ(Документ.Занятия.)) <> ЗНАЧЕНИЕ(Документ.Занятия.)
	                      |			ТОГДА ИСТИНА
	                      |		ИНАЧЕ ЛОЖЬ
	                      |	КОНЕЦ КАК ЕстьПодтверждение
	                      |ИЗ
	                      |	РегистрНакопления.Продажи КАК Продажи
	                      |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ОплатаЗанятий КАК ОплатаЗанятий
	                      |		ПО Продажи.Регистратор.Занятие = ОплатаЗанятий.Регистратор.Занятие
	                      |			И (Продажи.Регистратор.Занятие = &Занятие)
	                      |			И (ОплатаЗанятий.Регистратор.Занятие = &Занятие)");
	
	Запрос.УстановитьПараметр("Занятие", ЗанятиеСсылка);
	
	Результат = Запрос.Выполнить().Выбрать();
	
	Если Результат.Следующий() Тогда
		Если Результат.ЕстьПодтверждение И Результат.ЕстьОплата Тогда
			Возврат Истина;
		Иначе
			Возврат Ложь;
		КонецЕсли;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
	
КонецФункции

Процедура СоздатьПодтверждениеПроведения(ЗанятиеСсылка) Экспорт
	
	ДокументПодтверждение = Документы.ПодтверждениеЗанятия.СоздатьДокумент();
	ДокументПодтверждение.Дата = ТекущаяДата();
	ДокументПодтверждение.Занятие = ЗанятиеСсылка;
	ДокументПодтверждение.Записать(РежимЗаписиДокумента.Проведение);

КонецПроцедуры

Функция СоздатьПодтверждениеОплаты(ЗанятиеСсылка) Экспорт
	
	ДокументПодтверждениеОплаты = Документы.ПодтверждениеОплаты.СоздатьДокумент();
	ДокументПодтверждениеОплаты.Дата = ТекущаяДата();
	ДокументПодтверждениеОплаты.Занятие = ЗанятиеСсылка;
	ДокументПодтверждениеОплаты.Записать(РежимЗаписиДокумента.Проведение);
	
КонецФункции


Функция НайтиПодтверждениеПроведения(ЗанятиеСсылка) Экспорт
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	Продажи.Регистратор
	                      |ИЗ
	                      |	РегистрНакопления.Продажи КАК Продажи
	                      |ГДЕ
	                      |	Продажи.Регистратор.Занятие = &Занятие");
	Запрос.УстановитьПараметр("Занятие", ЗанятиеСсылка);
	Результат = Запрос.Выполнить().Выбрать();
	Если Результат.Следующий() Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

Функция НайтиПодтверждениеОплаты(ЗанятиеСсылка) Экспорт
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	ОплатаЗанятий.Регистратор
	                      |ИЗ
	                      |	РегистрНакопления.ОплатаЗанятий КАК ОплатаЗанятий
	                      |ГДЕ
	                      |	ОплатаЗанятий.Регистратор.Занятие = &Занятие");
	
	Запрос.УстановитьПараметр("Занятие", ЗанятиеСсылка);
	Результат = Запрос.Выполнить().Выбрать();
	Если Результат.Следующий() Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции


Функция ПолучитьКоличествоЗанятийПоТипуПродления(ТипПродления, ЗанятиеСсылка) Экспорт
	
	КоличествоЗанятий = 0;
	Если ТипПродления = Перечисления.ТипыПродленияЗанятий.НаНеделю Тогда
		КоличествоЗанятий = 1;
	ИначеЕсли ТипПродления = Перечисления.ТипыПродленияЗанятий.НаДвеНедели Тогда
		КоличествоЗанятий = 2;		
	ИначеЕсли ТипПродления = Перечисления.ТипыПродленияЗанятий.НаТриНедели Тогда
		КоличествоЗанятий = 3;
	ИначеЕсли ТипПродления = Перечисления.ТипыПродленияЗанятий.НаЧетыреНедели Тогда
		КоличествоЗанятий = 4;		
	ИначеЕсли ТипПродления = Перечисления.ТипыПродленияЗанятий.ДоКонцаМесяца Тогда
		МесяцТекущегоЗанятия = Месяц(ЗанятиеСсылка.Дата);		
		
		МесяцДляЦикла = МесяцТекущегоЗанятия;
		ДатаДляЦикла = ЗанятиеСсылка.Дата;
		
		Пока МесяцДляЦикла = МесяцТекущегоЗанятия Цикл
			
			ДатаДляЦикла = ДатаДляЦикла + 7 * 86400;
			МесяцДляЦикла = Месяц(ДатаДляЦикла);
			Если МесяцДляЦикла = МесяцТекущегоЗанятия Тогда
				КоличествоЗанятий = КоличествоЗанятий + 1;
			КонецЕсли;
			
		КонецЦикла;
	КонецЕсли;
	
	Возврат КоличествоЗанятий;
		
КонецФункции

Функция ПовторитьЗанятиеНаСервере(ЗанятиеСсылка, КоличествоПродлений) Экспорт
	
	Сч = 1;
	ЕстьОшибка = Ложь;
	
	Ученики = ПолучитьФИОУченикаИЛИГруппы(ЗанятиеСсылка.Уроки);
	
	Если Ученики.Количество() = 1 Тогда
		ФИО = Ученики[0].Наименование;
	Иначе
		ФИО = "Группы";
	КонецЕсли;
	
	ОтчетОбОперации = "Информация по новым урокам." + " " + ФИО + Символы.ПС;
		
	Пока Сч <= КоличествоПродлений Цикл
		
		ДатаНовогоУрока = ЗанятиеСсылка.Дата + 7 * Сч * 86400;
		
		НачатьТранзакцию();
		
		НовДок = Документы.Занятия.СоздатьДокумент();
		НовДок.Дата = ЗанятиеСсылка.Дата + 7 * Сч * 86400;
		ЗаполнитьЗначенияСвойств(НовДок, ЗанятиеСсылка,, "Дата, Номер, ТемаПреподователя, ТемаПоУчебнику, ДомашнееЗадание, Примечание");
		НовДок.Уроки.Загрузить(ЗанятиеСсылка.Уроки.Выгрузить());
		
		Для Каждого Урок из НовДок.Уроки Цикл
			Урок.ДатаНачала = ДатаНовогоУрока;
		КонецЦикла;
		
		Попытка
			НовДок.Записать(РежимЗаписиДокумента.Проведение);
			ЗафиксироватьТранзакцию();
			ОтчетОбОперации = ОтчетОбОперации + Символы.ПС + "Создано занятие на " + Строка(Формат(ДатаНовогоУрока," ДЛФ=DDT"));
		Исключение
			ОтчетОбОперации = ОтчетОбОперации + Символы.ПС + "!!!!!" + "    "+ "Занятие не было создано на дату: " + Строка(Формат(ДатаНовогоУрока," ДЛФ=DDT"));
			ОтменитьТранзакцию();
		КонецПопытки;
		
		Сч = Сч +1;

	КонецЦикла;	
	
	Возврат ОтчетОбОперации;
	
КонецФункции

// Функция возвращает массив учеников
//
// Параметры:
// ТаблицаУроков - Табличная часть с ссылочным полем на ученика "Обучающийся"
//
// Возвращаемое значение:
// Массив с именами учеников
//
Функция ПолучитьФИОУченикаИЛИГруппы(ТаблицаУроков);
	
	МассивУчеников = Новый Массив;
	Для Каждого СтрУрок из ТаблицаУроков Цикл
		МассивУчеников.Добавить(СтрУрок.Обучающийся);
	КонецЦикла;
	
	Возврат МассивУчеников;
	
КонецФункции

&НаСервере
Функция НайтиПересечениеВремениЗанятий(ЗанятиеСсылка, ДатаНачала, ДатаОкончания, Преподаватель, Продолжительность) Экспорт
	СообщениеПользователю = "";
	
	////++ Добавим Секунду к дате начала и отнимем секунду у даты окончания
	//ДатаНачала = ДатаНачала + 1;
	//ДатаОкончания = ДатаОкончания - 1;
	
	Запрос = Новый Запрос ("ВЫБРАТЬ
	                       |	РасписаниеЗанятий.Регистратор КАК Занятие,
	                       |	РасписаниеЗанятий.Обучающийся,
	                       |	РасписаниеЗанятий.Дисциплина,
	                       |	ДОБАВИТЬКДАТЕ(РасписаниеЗанятий.Период, МИНУТА, РасписаниеЗанятий.Длительность.ЗначениеМинут) КАК ДатаОкончания,
	                       |	РасписаниеЗанятий.Период КАК ДатаНачала
	                       |ПОМЕСТИТЬ ВТ
	                       |ИЗ
	                       |	РегистрСведений.РасписаниеЗанятий КАК РасписаниеЗанятий
	                       |ГДЕ
	                       |	РасписаниеЗанятий.Преподаватель = &Преподаватель
	                       |	И РасписаниеЗанятий.Регистратор <> &Занятие
	                       |;
	                       |
	                       |////////////////////////////////////////////////////////////////////////////////
	                       |ВЫБРАТЬ
	                       |	ВТ.Обучающийся,
	                       |	ВТ.Дисциплина,
	                       |	ВТ.ДатаОкончания,
	                       |	ВТ.ДатаНачала,
	                       |	СтатусыЗанятий.СтатусЗанятия
	                       |ИЗ
	                       |	ВТ КАК ВТ
	                       |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СтатусыЗанятий КАК СтатусыЗанятий
	                       |		ПО ВТ.Занятие = СтатусыЗанятий.Занятие
	                       |ГДЕ
	                       |	(ВТ.ДатаОкончания МЕЖДУ &ДатаНачала И &ДатаОкончания
	                       |			ИЛИ ВТ.ДатаНачала МЕЖДУ &ДатаНачала И &ДатаОкончания)
	                       |	И СтатусыЗанятий.СтатусЗанятия <> ЗНАЧЕНИЕ(Перечисление.СтатусыЗанятий.Перенесено)
	                       |	И СтатусыЗанятий.СтатусЗанятия <> ЗНАЧЕНИЕ(Перечисление.СтатусыЗанятий.Отменено)");
	Запрос.УстановитьПараметр("ДатаНачала",			ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания",	ДатаОкончания);
	Запрос.УстановитьПараметр("Преподаватель",	Преподаватель);
	Запрос.УстановитьПараметр("Занятие",					ЗанятиеСсылка);
	
	ТаблицаПересеченийПреподователей = Запрос.Выполнить().Выгрузить();		
	
	Если ТаблицаПересеченийПреподователей.Количество()>0 Тогда
		//СообщениеПользователю = "Преподаватель занят!" + Символы.ПС;
		Для Каждого СтрПересечение из ТаблицаПересеченийПреподователей Цикл
			
			Если СтрПересечение.ДатаОкончания = ДатаНачала Тогда
				Продолжить;
			ИначеЕсли СтрПересечение.ДатаНачала = ДатаНачала + Продолжительность Тогда
				Продолжить;
			КонецЕсли;
			
			СообщениеПользователю = СообщениеПользователю + "Преподаватель занят!" + Символы.Таб + 
			Формат(СтрПересечение.ДатаНачала,"ДФ='ddd, d MMM HH:mm:ss'") + " / " + 
			СтрПересечение.Обучающийся + " / " + СтрПересечение.Дисциплина + Символы.ПС;
		КонецЦикла;
	КонецЕсли;
	
	Обучающийся = ПолучитьОбучающегосяПоЗанятию(ЗанятиеСсылка);
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	РасписаниеЗанятий.Регистратор КАК Занятие,
	                      |	РасписаниеЗанятий.Обучающийся,
	                      |	РасписаниеЗанятий.Дисциплина,
	                      |	ДОБАВИТЬКДАТЕ(РасписаниеЗанятий.Период, МИНУТА, РасписаниеЗанятий.Длительность.ЗначениеМинут) КАК ДатаОкончания,
	                      |	РасписаниеЗанятий.Период КАК ДатаНачала
	                      |ПОМЕСТИТЬ ВТ
	                      |ИЗ
	                      |	РегистрСведений.РасписаниеЗанятий КАК РасписаниеЗанятий
	                      |ГДЕ
	                      |	РасписаниеЗанятий.Регистратор <> &Занятие
	                      |	И РасписаниеЗанятий.Обучающийся = &Обучающийся
	                      |;
	                      |
	                      |////////////////////////////////////////////////////////////////////////////////
	                      |ВЫБРАТЬ
	                      |	ВТ.Обучающийся,
	                      |	ВТ.Дисциплина,
	                      |	ВТ.ДатаОкончания,
	                      |	ВТ.ДатаНачала,
	                      |	СтатусыЗанятий.СтатусЗанятия
	                      |ИЗ
	                      |	ВТ КАК ВТ
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СтатусыЗанятий КАК СтатусыЗанятий
	                      |		ПО ВТ.Занятие = СтатусыЗанятий.Занятие
	                      |ГДЕ
	                      |	(ВТ.ДатаОкончания МЕЖДУ &ДатаНачала И &ДатаОкончания
	                      |			ИЛИ ВТ.ДатаНачала МЕЖДУ &ДатаНачала И &ДатаОкончания)
	                      |	И СтатусыЗанятий.СтатусЗанятия <> ЗНАЧЕНИЕ(Перечисление.СтатусыЗанятий.Перенесено)
	                      |	И СтатусыЗанятий.СтатусЗанятия <> ЗНАЧЕНИЕ(Перечисление.СтатусыЗанятий.Отменено)");
	
	Запрос.УстановитьПараметр("Обучающийся",	Обучающийся);
	Запрос.УстановитьПараметр("ДатаНачала",		ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания",	ДатаОкончания);
	Запрос.УстановитьПараметр("Занятие",		ЗанятиеСсылка);
	
	ТаблицаПересеченийОбучающегося = Запрос.Выполнить().Выгрузить();
	
	Если ТаблицаПересеченийОбучающегося.Количество()>0 Тогда
		//СообщениеПользователю = СообщениеПользователю + "У ученика уже есть занятие!" + Символы.ПС;
		Для Каждого СтрПересечение из ТаблицаПересеченийПреподователей Цикл
			Если СтрПересечение.ДатаОкончания = ДатаНачала Тогда Продолжить; КонецЕсли;
			СообщениеПользователю = СообщениеПользователю + "У ученика уже есть занятие!" + Символы.Таб + 
			Формат(СтрПересечение.ДатаНачала,"ДФ='ddd, d MMM HH:mm:ss'") + " / " + 
			СтрПересечение.Обучающийся + " / " + СтрПересечение.Дисциплина + Символы.ПС;
		КонецЦикла;
	КонецЕсли;
	
	Возврат СообщениеПользователю;	
		
КонецФункции

Функция ПолучитьОбучающегосяПоЗанятию(ЗанятиеСсылка) Экспорт
	
	Возврат	РегистрыСведений.РасписаниеЗанятий.ВернутьУченикаПоЗанятию(ЗанятиеСсылка);
	
КонецФункции

//dev
//&НаСервере
//Функция НайтиПересечениеВремениЗанятийПриПродлении(ЗанятиеСсылка, МассивСтруктурДат, Преподаватель) Экспорт
//	СообщениеПользователю = "";
//		
//	Запрос = Новый Запрос ("ВЫБРАТЬ
//	                       |	РасписаниеЗанятий.Регистратор КАК Занятие,
//	                       |	РасписаниеЗанятий.Обучающийся,
//	                       |	РасписаниеЗанятий.Дисциплина,
//	                       |	ДОБАВИТЬКДАТЕ(РасписаниеЗанятий.Период, МИНУТА, РасписаниеЗанятий.Длительность.ЗначениеМинут) КАК ДатаОкончания,
//	                       |	РасписаниеЗанятий.Период КАК ДатаНачала
//	                       |ПОМЕСТИТЬ ВТ
//	                       |ИЗ
//	                       |	РегистрСведений.РасписаниеЗанятий КАК РасписаниеЗанятий
//	                       |ГДЕ
//	                       |	РасписаниеЗанятий.Преподаватель = &Преподаватель
//	                       |	И РасписаниеЗанятий.Регистратор <> &Занятие
//	                       |;
//	                       |
//	                       |////////////////////////////////////////////////////////////////////////////////
//	                       |ВЫБРАТЬ
//	                       |	ВТ.Обучающийся,
//	                       |	ВТ.Дисциплина,
//	                       |	ВТ.ДатаОкончания,
//	                       |	ВТ.ДатаНачала,
//	                       |	СтатусыЗанятий.СтатусЗанятия
//	                       |ИЗ
//	                       |	ВТ КАК ВТ
//	                       |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СтатусыЗанятий КАК СтатусыЗанятий
//	                       |		ПО ВТ.Занятие = СтатусыЗанятий.Занятие
//	                       |ГДЕ
//	                       |	(ВТ.ДатаОкончания МЕЖДУ &ДатаНачала И &ДатаОкончания
//	                       |			ИЛИ ВТ.ДатаНачала МЕЖДУ &ДатаНачала И &ДатаОкончания)
//	                       |	И СтатусыЗанятий.СтатусЗанятия <> ЗНАЧЕНИЕ(Перечисление.СтатусыЗанятий.Перенесено)
//	                       |	И СтатусыЗанятий.СтатусЗанятия <> ЗНАЧЕНИЕ(Перечисление.СтатусыЗанятий.Отменено)");
//	Запрос.УстановитьПараметр("ДатаНачала",			ДатаНачала);
//	Запрос.УстановитьПараметр("ДатаОкончания",	ДатаОкончания);
//	Запрос.УстановитьПараметр("Преподаватель",	Преподаватель);
//	Запрос.УстановитьПараметр("Занятие",					ЗанятиеСсылка);
//	
//	ТаблицаПересеченийПреподователей = Запрос.Выполнить().Выгрузить();		
//	
//	Если ТаблицаПересеченийПреподователей.Количество()>0 Тогда
//		СообщениеПользователю = "Преподаватель занят!" + Символы.ПС;
//		Для Каждого СтрПересечение из ТаблицаПересеченийПреподователей Цикл
//			СообщениеПользователю = СообщениеПользователю + 
//			Формат(СтрПересечение.ДатаНачала,"ДФ='ddd, d MMM HH:mm:ss'") + " / " + 
//			СтрПересечение.Обучающийся + " / " + СтрПересечение.Дисциплина + Символы.ПС;
//		КонецЦикла;
//	КонецЕсли;
//	
//	Запрос = Новый Запрос("ВЫБРАТЬ
//	                      |	РасписаниеЗанятий.Регистратор КАК Занятие,
//	                      |	РасписаниеЗанятий.Обучающийся,
//	                      |	РасписаниеЗанятий.Дисциплина,
//	                      |	ДОБАВИТЬКДАТЕ(РасписаниеЗанятий.Период, МИНУТА, РасписаниеЗанятий.Длительность.ЗначениеМинут) КАК ДатаОкончания,
//	                      |	РасписаниеЗанятий.Период КАК ДатаНачала
//	                      |ПОМЕСТИТЬ ВТ
//	                      |ИЗ
//	                      |	РегистрСведений.РасписаниеЗанятий КАК РасписаниеЗанятий
//	                      |ГДЕ
//	                      |	РасписаниеЗанятий.Регистратор <> &Занятие
//	                      |;
//	                      |
//	                      |////////////////////////////////////////////////////////////////////////////////
//	                      |ВЫБРАТЬ
//	                      |	ВТ.Обучающийся,
//	                      |	ВТ.Дисциплина,
//	                      |	ВТ.ДатаОкончания,
//	                      |	ВТ.ДатаНачала,
//	                      |	СтатусыЗанятий.СтатусЗанятия
//	                      |ИЗ
//	                      |	ВТ КАК ВТ
//	                      |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СтатусыЗанятий КАК СтатусыЗанятий
//	                      |		ПО ВТ.Занятие = СтатусыЗанятий.Занятие
//	                      |ГДЕ
//	                      |	(ВТ.ДатаОкончания МЕЖДУ &ДатаНачала И &ДатаОкончания
//	                      |			ИЛИ ВТ.ДатаНачала МЕЖДУ &ДатаНачала И &ДатаОкончания)
//	                      |	И СтатусыЗанятий.СтатусЗанятия <> ЗНАЧЕНИЕ(Перечисление.СтатусыЗанятий.Перенесено)
//	                      |	И СтатусыЗанятий.СтатусЗанятия <> ЗНАЧЕНИЕ(Перечисление.СтатусыЗанятий.Отменено)");
//	Запрос.УстановитьПараметр("ДатаНачала",			ДатаНачала);
//	Запрос.УстановитьПараметр("ДатаОкончания",	ДатаОкончания);
//	Запрос.УстановитьПараметр("Занятие",					ЗанятиеСсылка);
//	
//	ТаблицаПересеченийОбучающегося = Запрос.Выполнить().Выгрузить();
//	
//	Если ТаблицаПересеченийОбучающегося.Количество()>0 Тогда
//		СообщениеПользователю = СообщениеПользователю + "У ученика уже есть занятие!" + Символы.ПС;
//		Для Каждого СтрПересечение из ТаблицаПересеченийПреподователей Цикл
//			СообщениеПользователю = СообщениеПользователю + 
//			Формат(СтрПересечение.ДатаНачала,"ДФ='ddd, d MMM HH:mm:ss'") + " / " + 
//			СтрПересечение.Обучающийся + " / " + СтрПересечение.Дисциплина + Символы.ПС;
//		КонецЦикла;
//	КонецЕсли;
//	
//	Возврат СообщениеПользователю;	
//		
//КонецФункции