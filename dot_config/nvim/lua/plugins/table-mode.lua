-- タイピングしながら自動でテーブルを整形する。CSV 変換・セル操作・スプレッドシート風の数式にも対応。
return {
  'dhruvasagar/vim-table-mode',
  cmd = {
    'TableModeToggle',
    'TableModeEnable',
    'TableModeDisable',
    'Tableize',
    'TableModeRealign',
    'TableAddFormula',
    'TableEvalFormulaLine',
    'TableSort',
  },
}
