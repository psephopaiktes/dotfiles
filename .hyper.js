const themeColor = '#FFCC66';

module.exports = {
  config: {
    updateChannel: 'stable',
    fontSize: 16,
    fontFamily: '"Ricty Diminished", Ricty, Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    fontWeight: 'normal',
    fontWeightBold: 'bold',
    lineHeight: 1.4,
    letterSpacing: 0,
    cursorColor: themeColor,
    cursorAccentColor: '#000',
    cursorShape: 'BLOCK',
    cursorBlink: true,
    foregroundColor: '#fff',
    // ↓ only for footer because of hyper-simple-vibrancy
    backgroundColor: '#FFFFFF11',
    selectionColor: `${themeColor}66`,
    borderColor: 'transparent',
    css: `
    .hyper_main {
      border: none;
      background-color: #00112299;
    }
    .tabs_borderShim {
      display: none;
    }
    .tab_tab {
      border: none;
    }
    .splitpane_divider {
      background-color: #00000011 !important;
    }
    .tab_tab.tab_active {
      color: ${themeColor};
      font-weight: bold;
    }
    .tab_tab::before {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      height: 2px;
      background-color: ${themeColor};
      opacity: 0;
      transition: none;
    }
    .tab_tab.tab_active::before {
      opacity: 1;
      transition: .4s ease-out;
    }
    .tab_textInner {
      text-overflow: ellipsis;
      overflow: hidden;
      max-width: 100%;
      padding: 0 24px 0 8px;
    }
    *::-webkit-scrollbar {
      width: 4px;
      height: 4px;
      background-color: transparent;
    }
    *::-webkit-scrollbar-track {
      background-color: transparent;
    }
    *::-webkit-scrollbar-thumb {
      background: rgba(255, 255, 255, 0.2);
    }
    *::-webkit-scrollbar-thumb:window-inactive {
      background: rgba(255, 255, 255, 0.1);
    }
    `,
    showHamburgerMenu: '',
    showWindowControls: '',
    padding: '16px 24px 0',
    windowSize: [640,480],
    colors: {
      black: '#282c34',
      red: '#e06c75',
      green: '#98c379',
      yellow: '#d19a66',
      blue: '#56b6c2',
      magenta: '#c678dd',
      cyan: '#56b6c2',
      white: '#d0d0d0',
      lightBlack: '#808080',
      lightRed: '#e06c75',
      lightGreen: '#98c379',
      lightYellow: '#d19a66',
      lightBlue: '#56b6c2',
      lightMagenta: '#c678dd',
      lightCyan: '#56b6c2',
      lightWhite: '#FFFFFF',
    },
    shell: '',
    shellArgs: ['--login'],
    bell: 'SOUND',
    copyOnSelect: false,
    defaultSSHApp: true,
    quickEdit: false,
    macOptionSelectionMode: 'vertical',
    webGLRenderer: true,
  },

  plugins: [
    "hyper-statusline",
    "hypercwd",
    "hyper-search",
    "hyper-pane",
    // "hyper-tab-icons",
    "hyper-simple-vibrancy",
  ],

  localPlugins: [],

  keymaps: {},

};
