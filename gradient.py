from PIL import Image as F,ImageFilter as M,ImageEnhance as G
import numpy as C
def A(w,h):
	B=None;H=[(0,(120,200,255)),(.18,(214,154,203)),(.38,(141,119,197)),(.5,(91,111,183)),(.75,(120,200,255)),(1,(154,242,248))];D=(C.linspace(0,1,w)[B]+C.linspace(0,1,h)[:,B])/2%1;I=C.zeros((h,w,3),float)
	for((E,N),(J,O))in zip(H,H[1:]):K=(D>=E)&(D<=J);L=(D[K]-E)/(J-E);I[K]=N*(1-L)[:,B]+O*L[:,B]
	A=F.fromarray(I.clip(0,255).astype('uint8'));P=G.Brightness(A.filter(M.GaussianBlur(12))).enhance(1.6);A=F.blend(A,P,.5);return G.Color(A).enhance(1.3)
A(580,440).save('gradient.png')
