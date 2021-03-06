function  writeRLEfile(sceneVoxFilename, sceneVox,camPoseArr,voxOriginWorld)
        sceneVoxArr = sceneVox(:);
        sceneVoxGrad = sceneVoxArr(2:end)-sceneVoxArr(1:(end-1));
        sceneVoxPeaks = find(abs(sceneVoxGrad) > 0);
        sceneVoxRLE = [sceneVox(sceneVoxPeaks(2:end))';(sceneVoxPeaks(2:end)-sceneVoxPeaks(1:(end-1)))'];
        sceneVoxRLE = [sceneVox(sceneVoxPeaks(1)),sceneVoxPeaks(1), ...
                        sceneVoxRLE(:)', ...
                       sceneVoxArr(sceneVoxPeaks(end)+1),length(sceneVoxArr)-sceneVoxPeaks(end)];
        fileID = fopen(sceneVoxFilename,'w');
        fwrite(fileID,single(voxOriginWorld),'single');
        fwrite(fileID,single(camPoseArr),'single');
        fwrite(fileID,uint32(sceneVoxRLE),'uint32');
        fclose(fileID);
    
end