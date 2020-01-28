---
layout: 'post'
title: 'Hammerspoon 사용하기'
description: '자동화 툴 Hammerspoon을 사용해 생산성 높이기'
date: '2020-01-28 23:24:18 +0900'
categories:
  - Mac
tags:
  - Tool
  - 자동화
---

# Hammerspoon

Hammerspoon은 스크립팅 언어인 [Lua](https://ko.wikipedia.org/wiki/%EB%A3%A8%EC%95%84_(%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D_%EC%96%B8%EC%96%B4) 를 사용해 Mac OS에서 자동화할 수 있는 툴입니다.  
이 툴을 사용하면 OS X API를 몰라도 Lua를 사용해 애플리케이션부터 화면, 파일, 오디오, 네트워크, 마우스 / 키보드 이벤트 등등을 다룰 수 있습니다.

## 설치

`brew` 를 사용해 설치할 수 있습니다.

    brew cask install hammerspoon

`brew` 가 없다면 [릴리즈 페이지](https://github.com/Hammerspoon/hammerspoon/releases)에서 `Hammerspoon-x.x.xx.zip`  파일을 다운로드 받아서 압축을 푼 다음 `/Applications/` 경로에 넣어줍니다. (또는 `응용 프로그램` 디렉토리)

## 설정

이제 프로그램을 실행시켜주면 상단의 메뉴바에 망치 모양의 아이콘이 생깁니다.  
우선 재부팅 시 프로그램이 자동으로 켜지지 않기 때문에 자동으로 켜지도록 아래와 같이 설정을 변경해줍니다.

- 메뉴바 아이콘 클릭 > Preferences > `Launch Hammerspoon at login` 옵션 체크

## 스크립트 작성

처음에는 아무 것도 없기 때문에 `~/.hammerspoon/init.lua` 에서 Lua로 필요한 것을 작성하면 됩니다. (또는 메뉴바 아이콘 메뉴에서 `Open Config` 메뉴를 선택하면 설정 파일이 열립니다.)

### Hello, World

우선, Hammerspoon 홈페이지에 있는 간단한 예제인 `Hello, World!` 를 출력해보겠습니다. `hs.hotkey.bind(기호, 키보드 키, 실행할 함수)` 를 사용하면 단축키를 지정할 수 있습니다. `init.lua` 에 아래와 같이 작성합니다.

    hs.hotkey.bind({"cmd", "option", "shift"}, "w", function ()
    	hs.alert.show("Hello, World!")
    end)

내용을 저장한 다음 메뉴바 아이콘에서 `Reload Config` 로 작성한 내용을 반영합니다.
이제 맥북의 `⌘ + ⌥ + ⇧ + w` 를 누르면 작성한 문구가 화면의 중앙에 표시됩니다.

### 키 바인딩

키 바인딩을 사용해 단축키 입력 시 자주 사용하는 응용 프로그램을 실행시켜보겠습니다.
`hs.hotkey.bind(기호, 키보드 키, 함수)` 에 사용 가능한 기호 및 키는 아래와 같습니다.

**기호**

영문 명칭 또는 기호를 사용할 수 있습니다.

- "cmd", "command" 또는 "⌘"
- "ctrl", "control" 또는 "⌃"
- "alt", "option" 또는 "⌥"
- "shift" 또는 "⇧"

**키보드 키**

키보드의 키와 숫자를 사용할 수 있으며, 알파벳, 숫자 외의 키는 아래와 같이 사용할 수 있습니다.

    f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15,
    f16, f17, f18, f19, f20, pad, pad*, pad+, pad/, pad-, pad=,
    pad0, pad1, pad2, pad3, pad4, pad5, pad6, pad7, pad8, pad9,
    padclear, padenter, return, tab, space, delete, escape, help,
    home, pageup, forwarddelete, end, pagedown, left, right, down, up,
    shift, rightshift, cmd, rightcmd, alt, rightalt, ctrl, rightctrl,
    capslock, fn

그리고 응용 프로그램을 실행시키기 위해 `hs.application.launchOrFocus(name)` 를 사용합니다. 이 기능은 응용 프로그램을 실행시킨 다음 포커스를 이동시켜주는 기능입니다. 여기에 들어갈 `name` 은 응용 프로그램 `오른쪽 클릭 > 정보 가져오기 > 이름 및 확장자` 를 입력해줍니다.

위 2개의 기능을 사용해 `init.lua` 에 아래와 같이 작성한 다음 Reload합니다.

    hs.hotkey.bind({"shift", "option", "ctrl"}, "c", function()
    	hs.application.launchOrFocus("Google Chrome") -- 확장자는 생략 가능
    end

`⇧ + ⌥ + ⌃ + c` 를 누르면 크롬이 실행됩니다!  
저는 여기에 단축키를 누르면 응용 프로그램이 열리고, 다시 누르면 숨겨지도록 내용을 추가해서 사용 중입니다. 자세한 코드는 [여기서](https://github.com/hongsii/dotfiles/blob/master/hammerspoon/hammerspoon.symlink/modules/apps.luahttps://github.com/hongsii/dotfiles/blob/master/hammerspoon/hammerspoon.symlink/modules/apps.lua) 확인할 수 있습니다.

## 모듈

`init.lua` 에 여러 가지 스크립트를 작성하다 보면 내용이 점점 복잡해집니다. 이를 해결하기 위해 기능별로 파일을 분리하고, Lua의 `require` 를 통해 모듈을 설정하도록 해보겠습니다.  

`~/.hammerspoon` 경로에 모듈을 모아둘 디렉토리를 생성합니다. 저는 `modules` 라는 이름으로 만들었습니다. 그리고 생성한 디렉토리에 위에 작성한 응용 프로그램 단축키 스크립트를 `apps.lua` 파일로 만들어줍니다.  
`init.lua` 에 모듈을 적용하는 코드를 작성합니다. 이제 새로운 모듈이 추가될 때 마다 모듈만 추가해주면 `init.lua` 를 깔끔하게 관리할 수 있습니다.
제가 사용 중인 모듈은 [여기서](https://github.com/hongsii/dotfiles/tree/master/hammerspoon/hammerspoon.symlink/modules) 확인할 수 있습니다.

    -- init.lua가 있는 디렉토리로 부터 상대경로를 사용해 모듈을 불러올 수 있습니다.
    require("modules.apps") -- modules/apps 로도 적용 가능


그리고 저는 모듈을 추가할 때마다 수동으로 입력하기가 번거로워 모듈 디렉토리를 읽어서 파일을 자동으로 적용하도록 스크립트를 작성했습니다. 자세한 코드는 [여기서](https://github.com/hongsii/dotfiles/blob/master/hammerspoon/hammerspoon.symlink/init.lua) 확인할 수 있습니다.

---

# 참고

- [Hammerspoon](https://www.hammerspoon.org/)
- [Hammerspoon docs](https://www.hammerspoon.org/docs/index.html)
- [해머스푼으로 한/영 전환 오로라를 만들자](https://johngrib.github.io/wiki/hammerspoon-inputsource-aurora/)
