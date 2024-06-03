#export LD_LIBRARY_PATH=/opt/libtorch-cpu/lib

%.mkv: %.ts filter.txt
	ffmpeg_vaapi \
		-vaapi_device /dev/dri/renderD128 \
		-i '$*'.ts \
		-c:v hevc_vaapi \
		-rc_mode CQP \
		-q $(QUALITY)\
		-filter_complex_script filter.txt \
		'$*'.mkv


.PHONY: %.test
%.test: %.ts filter.txt
	ffmpeg_vaapi \
		-vaapi_device /dev/dri/renderD128 \
		-y \
		-i '$*'.ts \
		-c:v hevc_vaapi \
		-rc_mode CQP \
		-q $(QUALITY) \
		-/filter_complex filter.txt \
		-t 120 \
		'$*'.test.mkv
#	ffmpeg_vaapi \
#		-y \
#		-i '$*'.ts \
#		-c:v copy \
#		-t 120 \
#		'$*'.compare.ts
#	ffmpeg -i '$*.compare.ts' -i '$*.test.mkv' -lavfi libvmaf='n_threads=6' -f null -		
#	stat --format %s '$*.compare.ts' | numfmt --to iec --format "%8.4f" 
#	stat --format %s '$*.test.mkv' | numfmt --to iec --format "%8.4f"

