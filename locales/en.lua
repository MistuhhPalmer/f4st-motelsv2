local Translations = {
    error = {
        ['Şu anda müsait oda bulunmamakta!'] = 'There are no available rooms at the moment',
        ['Yeterli paranız bulunmamakta"'] = 'You do not have enough money',
        ['Yeterli paranız bulunmamakta'] = 'You do not have enough money',
    },
    success = {
        ['Başarıyla orta motel odası satın aldınız!'] = 'You have successfully purchased a medium motel room!',
        ['Başarıyla büyük motel odası satın aldınız!'] = 'You have successfully purchased a large motel room!',
        ['Basit motel odası satın alındı'] = 'Purchased basic motel room',
        ['Büyük motel odası satın alındı'] = 'Purchased large motel room',
    },
    info = {
        ['[E] - Motel Menüsü'] = '[E] - Motel Menu',
        ['Motel Menüsü'] = 'Motel Menu',
        ['Odana Gir'] = 'Enter Room',
        ['Sahip olduğunuz motel odasına girer'] = 'Enters your owned motel room',
        ['Motel Odası Satın Al'] = 'Buy Motel Room',
        ['Yeni motel odası satın almanızı sağlar'] = 'Allows you to buy a new motel room',
        ['Menüyü Kapat'] = 'Close Menu',
        ['Motel menüsünü kapatır'] = 'Closes the motel menu',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})