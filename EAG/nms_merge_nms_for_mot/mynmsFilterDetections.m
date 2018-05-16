% Copyright (c) 2015 Niall McLaughlin, CSIT, Queen's University Belfast, UK
% Contact: nmclaughlin02@qub.ac.uk
% If you use this code please cite:
% "Enhancing Linear Programming with Motion Modeling for Multi-target Tracking",
% N McLaughlin, J Martinez Del Rincon, P Miller, 
% IEEE Winter Conference on Applications of Computer Vision (WACV), 2015 
% 
% This software is licensed for research and non-commercial use only.
% 
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.


%remove detections that are overlapping by >= nmsThreshold
function toKeep = nmsFilterDetections(detections,nmsThreshold)

    nFrames = max(detections(:,1));
    toKeep = zeros(1,size(detections,1));
        
    for f = 1:nFrames
        if f==107
            iiii=0;
        end
        detsThisFrame = detections(detections(:,1) == f,:);

        %place the detections onto the scene one by one
        %if we overlap with an exisitng detection by > threshold - don't
        %place on the scene
%zxy0827
        [tmp_wuyong,order] = sort(detsThisFrame(:,7),'descend');
        detsThisFrame = detsThisFrame(order,:);
        
        inScene = ones(1,size(detsThisFrame,1));
        %此时自身冲突已经消失
        %仅需删除与老框的矛盾
        for det_i = 1:size(detsThisFrame,1) %place 
            if detsThisFrame(det_i,11)==0
                for det_j = 1:size(detsThisFrame,1) %place 
                     if getOverlap(detsThisFrame(det_i,:),detsThisFrame(det_j,:)) > nmsThreshold...
                             && detsThisFrame(det_j,11)==1
                         inScene(det_i)=0;
                     end
                end
            end
        end
       
        tmp_ind=find(detections(:,1) == f);
%         tmp_ind=tmp_ind(order);
        toKeep((tmp_ind)) = inScene;  
    end

end

%get the overlap between two detecitons
function overlap = getOverlap(a,b)    
    inter = rectint([a(3:4) a(5) a(6)],[b(3:4) b(5) b(6)]);
    union = (a(5) * a(6)) + (b(5) * b(6)) - inter;
    overlap = inter / union;
end