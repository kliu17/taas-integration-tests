control 'cicd-pod-deployed' do
  title 'cicd pod deployed'
  impact 1.0
  describe command("helm ls |grep cicd | awk -F' ' '{print $8;}'") do
    its('stdout.strip') { should eq 'DEPLOYED' }
  end
end

control 'report-pod-deployed' do
  title 'report pod deployed'
  impact 1.0
  describe command("helm ls |grep report | awk -F' ' '{print $8;}'") do
    its('stdout.strip') { should eq 'DEPLOYED' }
  end
end

control 'store-pod-deployed' do
  title 'store pod deployed'
  impact 1.0
  describe command("helm ls |grep store | awk -F' ' '{print $8;}'") do
    its('stdout.strip') { should eq 'DEPLOYED' }
  end
end

control 'log-collector-pod-deployed' do
  title 'log collector pod deployed'
  impact 1.0
  describe command("helm ls |grep log-collector | awk -F' ' '{print $8;}'") do
    its('stdout.strip') { should eq 'DEPLOYED' }
  end
end

control 'jenkins-pod-running' do
  title 'jenkins pod running'
  impact 1.0
  describe command("kubectl get pods |grep jenkins | awk -F' ' '{print $3;}'") do
    its('stdout.strip') { should eq 'Running' }
  end
end

control 'ambassador-pod-running' do
  title 'ambassador pod running'
  impact 1.0
  describe command("kubectl get pods |grep ambassador | awk -F' ' '{print $3;}'") do
    its('stdout.strip') { should eq 'Running' }
  end
end

control 'kibana-pod-running' do
  title 'kibana pod running'
  impact 1.0
  describe command("kubectl get pods |grep kibana | awk -F' ' '{print $3;}'") do
    its('stdout.strip') { should eq 'Running' }
  end
end

control 'elasticsearch-client-pod-running' do
  title 'elasticsearch-client pod running'
  impact 1.0
  describe command("kubectl get pods |grep elasticsearch-client | awk -F' ' '{print $3;}'") do
    its('stdout.strip') { should eq 'Running' }
  end
end

control 'elasticsearch-data-0-pod-running' do
  title 'elasticsearch-data-0 pod running'
  impact 1.0
  describe command("kubectl get pods |grep elasticsearch-data-0 | awk -F' ' '{print $3;}'") do
    its('stdout.strip') { should eq 'Running' }
  end
end

control 'elasticsearch-master-0-pod-running' do
  title 'elasticsearch-master-0 pod running'
  impact 1.0
  describe command("kubectl get pods |grep elasticsearch-master-0 | awk -F' ' '{print $3;}'") do
    its('stdout.strip') { should eq 'Running' }
  end
end

control 'elasticsearch-master-1-pod-running' do
  title 'elasticsearch-master-1 pod running'
  impact 1.0
  describe command("kubectl get pods |grep elasticsearch-master-1 | awk -F' ' '{print $3;}'") do
    its('stdout.strip') { should eq 'Running' }
  end
end


