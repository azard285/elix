# То что нужно знать и попробовать распределить

## Различные определения

### Что такое DTMF?

DTMF (Dual-Tone Multi-Frequency) — это звуковые сигналы, которые телефоны используют для набора номера или отправки команд (например, *1#).

В SIP DTMF можно передать тремя способами:
In-band (в RTP-потоке)
- Как аудиосигналы (старый метод, может теряться при кодировании).

Out-of-band (RFC 2833)
- Специальные RTP-пакеты с меткой telephone-event.

SIP INFO
- Отдельный SIP-запрос с DTMF в теле.

### Что такое SDP?

SDP (Session Description Protocol) — текстовая информация о медиа-сессии, которую SIP-участники обмениваются в INVITE и 200 OK.

```
v=0
o=FreeSWITCH 1675223553 1675223554 IN IP4 192.168.1.1
s=Radio Stream
c=IN IP4 192.168.1.1
t=0 0
m=audio 20000 RTP/AVP 0 101
a=rtpmap:0 PCMU/8000
a=rtpmap:101 telephone-event/8000
```
Библиотеки:
- ex_sdp — парсинг/генерация SDP.
- erlang-sdp — чистый Erlang.


### RTP/RTCP и Jitter Buffer

RTP (Real-time Transport Protocol)
- Передаёт аудио/видео в реальном времени.
- Каждый пакет содержит:
    - Таймстамп (время создания).
    - Порядковый номер (для сборки).


RTCP (RTP Control Protocol)

Контроль качества связи:
- Потеря пакетов (loss %).
- Задержка (jitter).


Jitter Buffer

Проблема: Пакеты приходят с разной задержкой (jitter).
Решение: Буфер на 20-200 мс, который накапливает пакеты перед воспроизведением.

Библиотеки:
- rtp — кодирование/декодирование RTP.
- erlang-rtp — низкоуровневая работа.


## Различные инструменты для erlang

### Обработка SIP (Session Initiation Protocol)

Библиотеки:
- ersip — чистый Erlang SIP-стек (RFC 3261).
- esip — альтернатива с поддержкой WebRTC.
- gen_sip — OTP-подобное поведение для SIP.

Что умеют:
- Парсинг/генерация SIP-запросов (INVITE, BYE, REFER, INFO).
- Работа с заголовками (Via, From, To, CSeq).
- Поддержка NAT (через STUN).

```
для себя 
Пример обработки INVITE:

handle_request(#sip_request{method = <<"INVITE">>} = Req, State) ->
    {ok, Body} = ersip_sdp:parse(Req#sip_request.body),
    Codec = get_preferred_codec(Body),  % Анализ SDP
    {ok, Resp} = ersip_reply:reply(200, <<"OK">>, Req),
    ersip:send_response(Resp),
    {noreply, State#state{codec = Codec}}.
```

### Работа с SDP (Session Description Protocol)

Библиотеки:
- ersip_sdp — часть ersip.
- ex_sdp — Elixir-обёртка

### Транспорт RTP/RTCP

Библиотеки:
- rtp — кодирование/декодирование RTP.
- erlang-rtp — низкоуровневая реализация.
- ffmpeg — транскодинг через порты.

### Обработка DTMF

Варианты:
- Через SIP INFO

```
handle_request(#sip_request{method = <<"INFO">>, body = <<"Signal=*1#">>}, State) ->
    NextNumber = get_next_stream(State),
    ReferTo = <<"sip:", NextNumber/binary, "@server">>,
    ersip:send_request(ersip_request:refer(ReferTo)).
```

- Через RFC 2833 (в RTP)
    Анализ пакетов с payload_type=101.

### Jitter Buffer

## серверы для обработки VoIP/SIP-трафика

### FreeSWITCH

Ето: 
- Телефонная платформа с поддержкой SIP, WebRTC, PSTN.
- Умеет: маршрутизировать звонки, работать с медиа (RTP), обрабатывать DTMF, транскодировать аудио.
- Гибкость: Конфигурация на Lua, XML, API через ESL (Event Socket).

Зач нужна: 
- Принимать SIP-вызовы и проигрывать RTP-потоки.
- Обрабатывать DTMF-команды (*1#).
- Генерировать REFER для переключения станций.

Установка (Docker):

``docker run -d --name freeswitch -p 5060:5060/udp -p 20000-30000:20000-30000/udp freeswitch/freeswitch

### Kamailio

Ето:
- SIP-прокси/роутер (без работы с медиа — только сигнализация).
- Умеет: маршрутизировать SIP-запросы, балансировать нагрузку, защищаться от DDoS.
- Оптимизация: Обрабатывает до 10k+ вызовов в секунду.

Зач нужна: 
- Если нужно масштабироваться на тысячи абонентов.
- Для сложной маршрутизации (например, гео-балансировка).


## Docker

Нужен уже как раз для интеграции FreeSWITCH/Kamailio

Пример портов: 
- 5060/udp - SIP
- 20000-30000/udp - RTP (для аудио)

Подключение сервисов:
- баз данных типа PostgreSQL
- мониторинг, через тото же Prometheus с Grafana, отлов ошибок alertmanager(ну тут не обязательно как и остальное) и тд
- STUN/TURN-сервер (для NAT)




```
про elixir не буду потому что там одно и то же грубо говоря, различия в реализации, бибоиотеках и мелочах
основные иснтрументы все те же самые
```
