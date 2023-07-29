﻿&НаКлиенте
Перем ЭлементОтбораОбучающийся, ЭлементОтбораТолькоБудущие;

&НаКлиенте
Процедура ОбучающийсяФильтрПриИзменении(Элемент)
	Если ЭлементОтбораОбучающийся = Неопределено Тогда
		
		ЭлементОтбораОбучающийся = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбораОбучающийся.ЛевоеЗначение		= Новый ПолеКомпоновкиДанных("Обучающийся");
		ЭлементОтбораОбучающийся.ВидСравнения		= ВидСравненияКомпоновкиДанных.Равно;
		//ЭлементОтбора.Использование		= Истина;
		
	КонецЕсли;
	
	Если Обучающийся.Пустая() Тогда
		ЭлементОтбораОбучающийся.Использование = Ложь;
	Иначе
		ЭлементОтбораОбучающийся.Использование = Истина;
		ЭлементОтбораОбучающийся.ПравоеЗначение = Обучающийся;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	НастоящееВремя = ТекущаяДата();
КонецПроцедуры

&НаКлиенте
Процедура ТолькоБудущиеПриИзменении(Элемент)
	Если ЭлементОтбораТолькоБудущие = Неопределено Тогда
		
		ЭлементОтбораТолькоБудущие = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбораТолькоБудущие.ЛевоеЗначение		= Новый ПолеКомпоновкиДанных("Дата");
		ЭлементОтбораТолькоБудущие.ВидСравнения			= ВидСравненияКомпоновкиДанных.Больше;
		//ЭлементОтбора.Использование		= Истина;
		
	КонецЕсли;
	
	Если ТолькоБудущие Тогда
		ЭлементОтбораТолькоБудущие.Использование = Истина;
		ЭлементОтбораТолькоБудущие.ПравоеЗначение = ТекущаяДата();
	Иначе
		ЭлементОтбораТолькоБудущие.Использование = Ложь;
	КонецЕсли;

КонецПроцедуры
