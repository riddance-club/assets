from PIL import Image
import numpy as np
def g(w,h):
 s=[(0,(154,242,248)),(0.18,(214,154,203)),(0.38,(141,119,197)),(0.725,(91,111,183)),(0.99,(120,200,255)),(1,(154,242,248))]
 t=((np.linspace(0,1,w)[None,:]+np.linspace(0,1,h)[:,None])/2)%1
 a=np.zeros((h,w,3),float)
 for(p0,c0),(p1,c1) in zip(s,s[1:]):
  m=(t>=p0)&(t<=p1)
  l=(t[m]-p0)/(p1-p0)
  a[m]=(1-l)[:,None]*c0+l[:,None]*c1
 return Image.fromarray(a.clip(0,255).astype('uint8'))
g(580,440).save('gradient.png')
