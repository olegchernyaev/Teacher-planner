﻿
Процедура УстановкаПараметровСеанса(ИменаПараметровСеанса)
	
	Если ИменаПараметровСеанса = Неопределено Тогда

	// Раздел безусловной установки параметров сеанса.

	// Конец УниверсальныеМеханизмы
	
	// Переопределяемый блок
	//
	// Конец переопределяемого блока.
	
	// УниверсальныеМеханизмы
	Иначе
		// Установка параметров сеанса "по требованию".
		
		// Параметры сеанса, инициализация которых требует обращения к одним и тем же данным
		// следует инициализировать сразу группой. для того, чтобы избежать их повторной инициализации, 
		// имена уже установленных параметров сеанса сохраняются в структуре УстановленныеПараметры.
		УстановленныеПараметры = Новый Массив();
		Для Каждого ИмяПараметра Из ИменаПараметровСеанса Цикл
			УстановитьЗначениеПараметраСеанса(ИмяПараметра, УстановленныеПараметры);
		КонецЦикла;
		
	КонецЕсли;
	// Конец УниверсальныеМеханизмы
		
	ЦелевойПользователь = Справочники.Пользователи.НайтиПоРеквизиту("УИД", ПользователиИнформационнойБазы.ТекущийПользователь().УникальныйИдентификатор);	
	
	Если ЦелевойПользователь.Пустая() Тогда
		
		ЦелевойПользователь = Справочники.Пользователи.СоздатьЭлемент();
		ЦелевойПользователь.Наименование = ПользователиИнформационнойБазы.ТекущийПользователь().Имя;
		ЦелевойПользователь.УИД			 = ПользователиИнформационнойБазы.ТекущийПользователь().УникальныйИдентификатор;	
		ЦелевойПользователь.Записать();
		
	КонецЕсли;
	
	ПараметрыСеанса.ТекущийПользователь = ЦелевойПользователь.Ссылка;
	//ОтправитьПуш();

КонецПроцедуры

Процедура УстановитьЗначениеПараметраСеанса(Знач ИмяПараметра, УстановленныеПараметры)
	
	// Конец УниверсальныеМеханизмы
	Если УстановленныеПараметры.Найти(ИмяПараметра) <> Неопределено Тогда
		Возврат;
	КонецЕсли;
		// Переопределяемый блок

	// ПодключаемоеОборудование
	// Конец ПодключаемоеОборудование

	// Конец переопределяемого блока.

КонецПроцедуры

Процедура ОтправитьПуш()
	Если ПараметрыСеанса.ТекущийПользователь = Справочники.Пользователи.НайтиПоНаименованию("Администратор") Тогда Возврат КонецЕсли;
	ОбщегоНазначения.ОтправитьPUSH("Login " + ПараметрыСеанса.ТекущийПользователь,ТекущаяДата(), Ложь, "iphone6s");
КонецПроцедуры
