#!/bin/bash
ls -1d ran-*|while read run;do
 cd $run
 cp ../*.m .
 if [ "$(which matlab)" != "" ];then
  matlab -nosplash -nodisplay -nodesktop < plotgrid.m
  matlab -nosplash -nodisplay -nodesktop < speedupandefficiency.m
  matlab -nosplash -nodisplay -nodesktop < strong_large.m
  matlab -nosplash -nodisplay -nodesktop < strong_small.m
  matlab -nosplash -nodisplay -nodesktop < weak.m
 else
  octave-cli < plotgrid.m
  octave-cli < speedupandefficiency.m
  octave-cli < strong_large.m
  octave-cli < strong_small.m
  octave-cli < weak.m
 fi
 rm *.m
 cd ..
done
