function getTr(s) {
    if (ankiLanguage !== 'zh-CN') return s;
    else switch (s) {
        case 'Back Links':
            return '反向链接'
        case 'Forward Links':
            return '正向链接'
        case 'None':
            return '无'
        case 'Invalid note':
            return '无效笔记'
        case 'Invalid link':
            return '无效链接'
        case 'Basic':
            return '基础'
        case 'Global Relationship Graph':
            return '全局关系图'
        case 'Shortcut keys':
            return '快捷键'
        case 'left':
            return '左'
        case 'right':
            return '右'
        case 'Automatically show links panel when entering editor':
            return '进入编辑器时自动显示链接面板'
        case 'Automatically show graph panel when entering editor':
            return '进入编辑器时自动显示关系图面板'
        case 'Automatically show links panel when entering reviewer':
            return '进入复习界面时自动显示链接面板'
        case 'Collapse cloze in links panel':
            return '折叠链接面板中的完形填空'
        case 'If the "hjp-linkmaster" add-on is installed, use its previewer':
            return '如果安装了“hjp-linkmaster”插件，则使用它的预览器'
        case 'The position of links/graph panel relative to the editor':
            return '链接/图形面板相对于编辑器的位置'
        case 'The position of links panel relative to the reviewer':
            return '链接面板相对于复习界面的位置'
        case 'Split ratio between editor and panels':
            return '编辑器和面板之间的显示比例'
        case 'Split ratio between links panel and graph panel':
            return '链接面板和图形面板之间的显示比例'
        case 'Split ratio between reviewer and links panel':
            return '复习界面和链接面板之间的显示比例'
        case 'Note fields displayed in the note summary':
            return '笔记摘要中显示的笔记字段'
        case 'Default search text':
            return '默认搜索文本'
        case 'Default filter text for highlighted nodes':
            return '高亮节点的默认筛选文本'
        case 'Default display of single nodes':
            return '默认显示单独的节点'
        case 'Default display of tag nodes':
            return '默认显示标签节点'
        case 'Node color':
            return '节点颜色'
        case 'Highlighted node color':
            return '高亮节点颜色'
        case 'Tag node color':
            return '标签节点颜色'
        case 'Graph background color':
            return '图背景颜色'
        case 'Restore Defaults':
            return '恢复默认值'
        case 'Cancel':
            return '取消'
        case 'OK':
            return '确认'
        case 'The format of "split ratio" is incorrect':
            return '“显示比例”的格式不正确'
        case 'Max displayed lines per link in links panel':
            return '链接面板中每个链接的最大显示行数'
        case 'Copy current note ID':
            return '复制当前笔记ID'
        case 'Copy current note link':
            return '复制当前笔记链接'
        case 'Open current note in new window':
            return '在新窗口中打开当前笔记'
        case 'Insert link with copied note ID':
            return '插入带有已复制的笔记ID的链接'
        case 'Insert new link':
            return '插入新链接'
        case 'Insert link template':
            return '插入链接模版'
        case 'The note fields displayed in the note summary (content shown in the link panel or graphic). \n' +
        'The add-on will find the first matching field to display as the note summary. \n' +
        'If no field is set or there is no matching field, the first field of the note will be used by default.':
            return '在笔记摘要（链接面板或图形中显示的内容）中显示的笔记字段。\n插件将找到第一个匹配的字段将其显示为笔记摘要。\n如果没有设定或没有匹配的字段，则默认使用笔记的第一个字段。'
        default:
            return s
    }
}