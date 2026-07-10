grep 'sizeof("CHAR")' tmp.h | sed -e 's|^.*\(stringpool_str[0-9]*\).*$|  (int)(size_t)\&((struct stringpool_t *)0)->\1,|'
grep 'sizeof("WCHAR_T")' tmp.h | sed -e 's|^.*\(stringpool_str[0-9]*\).*$|  (int)(size_t)\&((struct stringpool_t *)0)->\1,|'
