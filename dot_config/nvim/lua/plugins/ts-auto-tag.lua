-- Tree-sitter を使って HTML タグを自動で閉じ、タグ名変更時にペアも自動で更新する。
return {
  'windwp/nvim-ts-autotag',
  opts = {
    enable = true,
  },
  ft = {
    'astro',
    'glimmer',
    'handlebars',
    'html',
    'javascript',
    'jsx',
    'markdown',
    'php',
    'rescript',
    'svelte',
    'tsx',
    'typescript',
    'typescriptreact',
    'vue',
    'xml',
  },
}
