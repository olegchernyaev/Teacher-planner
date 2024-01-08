﻿
#Область ПрограммныйИнтерфейс

Функция ИзалечьСлучайноеПожелание(Период, Пользователь) Экспорт
	
	ТекстПожелания = "";	
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	СлучайныеПожелания.Период КАК Период,
	                      |	СлучайныеПожелания.Пользователь КАК Пользователь,
	                      |	СлучайныеПожелания.ТекстПожелания КАК ТекстПожелания
	                      |ИЗ
	                      |	РегистрСведений.СлучайныеПожелания КАК СлучайныеПожелания
	                      |ГДЕ
	                      |	СлучайныеПожелания.Период = &Период
	                      |	И СлучайныеПожелания.Пользователь = &Пользователь
	                      |	И СлучайныеПожелания.БылоВыведено = ЛОЖЬ");
	
	Запрос.УстановитьПараметр("Период", Период);
	Запрос.УстановитьПараметр("Пользователь", Пользователь);
	
	Результат = Запрос.Выполнить();
	
	Если Результат.Пустой() Тогда
		Возврат ТекстПожелания;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	
	Запись = СоздатьМенеджерЗаписи();
	Запись.Период = Выборка.Период;
	Запись.Пользователь = Выборка.Пользователь;
	
	Запись.Прочитать();
	
	Если Запись.Выбран() Тогда
		Запись.БылоВыведено = Истина;
		Запись.Записать();
		Возврат Запись.ТекстПожелания;
	КонецЕсли;
		
КонецФункции

Функция СоздатьЗапись(Период, Пользователь, ТекстПожелания) Экспорт
	
	Запись = СоздатьМенеджерЗаписи();
	Запись.Период = Период;
	Запись.Пользователь = Пользователь;
	Запись.ТекстПожелания = ТекстПожелания;
	
	Запись.Записать();
	
КонецФункции

Функция НеобходимоСгенерироватьПожелания(Пользователь, Дата) Экспорт
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	СлучайныеПожелания.ТекстПожелания КАК ТекстПожелания
	                      |ИЗ
	                      |	РегистрСведений.СлучайныеПожелания КАК СлучайныеПожелания
	                      |ГДЕ
	                      |	СлучайныеПожелания.Пользователь = &Пользователь
	                      |	И СлучайныеПожелания.Период = &Дата");
	
	Запрос.УстановитьПараметр("Пользователь", Пользователь);
	Запрос.УстановитьПараметр("Дата", Дата);
	
	Возврат Запрос.Выполнить().Пустой();
	
КонецФункции

#КонецОбласти