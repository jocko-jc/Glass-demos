Rebol [
    title: "GLASS - simple image viewer"
    Author: "jocko"
    date: 2011-04-01
    
    documentation: {
        Simple viewer ...
        later, it could accept image effects     
    }
]

; execute SLIM library manager
do %../libs/slim.r

; open GLASS
gl: slim/open 'glass none

slim/open/expose 'glass-libs none [gl liquid-lib]
slim/open/expose 'liquid none [fill liquify !plug]
slim/open/expose 'liquid none [content link fill]

;ctr: 0
;lcr: 0

change-dir %../images

set-image: func [im-file][
	liquid-lib/fill ccc/aspects/image load to-file im-file
	set [path file] split-path to-file im-file
	liquid-lib/fill lbl/aspects/label to-string file
]


gui: gl/layout/size compose/deep [

		lbl: field "choose an image"
		row [
			button stiff "load image" [set-image request-file "load an image file"  ] 
			button stiff "set contrast" ;[ccc/effect: [fit contrast 0] show ccc]
			hstretch
			button stiff "close" (red * 0.6) [quit]]
		scroller  ;[ctr: -128 + (255 * sss/data) ccc/effect: copy [fit luma lcr contrast ctr] show ccc]
		scroller ;[lcr: -128 + (255 * lll/data) ccc/effect: copy [fit luma lcr contrast ctr] show ccc]
		scroll-frame [
					;ccc: canvas 200x200 with [image: img static-size: 200x200 color: none effect: [fit]]
					ccc: image 300x300; with [liquid-lib/fill aspects/image img]
		]
] 400x400

link/reset  ccc/aspects/label lbl/aspects/label
set-image %marble.png

do-events
