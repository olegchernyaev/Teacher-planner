﻿
Процедура ОбработкаПроведения(Отказ, Режим)
	
	Движения.РасценкиЗанятий.Записывать = Истина;
	
	Для Каждого ТекСтрокаРасценкиЗанятий Из РасценкиЗанятий Цикл
		Движение = Движения.РасценкиЗанятий.Добавить();
		Движение.Период = Дата;
		Движение.Преподаватель = Преподаватель;
		Движение.ДлительностьЗанятия = ТекСтрокаРасценкиЗанятий.ДлительностьЗанятия;
		Движение.Обучающийся	= ТекСтрокаРасценкиЗанятий.Обучающийся;
		Движение.Цена = ТекСтрокаРасценкиЗанятий.Цена;
	КонецЦикла;
	
КонецПроцедуры
