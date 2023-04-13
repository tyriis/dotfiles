import datetime

TEXT_COLOR = '#000000'
ICON_COLOR = '#4C88B3'

def pango(text, color=TEXT_COLOR, size=None):
    params = {'foreground': color}
    if size != None: params['font_size'] = size
    p = " ".join("%s='%s'" % (k,v) for k, v in params.items())
    return "<span %s>%s</span>" % (p, text)

def icon(font_awesome, color=ICON_COLOR):
    return pango(font_awesome, color, 'large')


now = datetime.datetime.now()
txt = pango(now.strftime('%a %m/%d %H:%M'))

ic = icon('')

print("%s %s" % (ic, txt))