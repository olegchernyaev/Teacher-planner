﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Список.Параметры.УстановитьЗначениеПараметра("ТекущаяДата", ТекущаяДата());
КонецПроцедуры

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ТекЭлемент	= Элементы.Список.ТекущийЭлемент.Имя;
	ТекДанные	= Элементы.Список.ТекущиеДанные;
	ОткрытьЗначение(ТекДанные[ТекЭлемент]);
КонецПроцедуры
