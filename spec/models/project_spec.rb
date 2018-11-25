require 'spec_helper'

describe Project do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:owner) }
  it { should belong_to(:owner) }

  describe "#status" do
    context "new projects" do
      subject(:project) { Project.new }

      it "begins with an active status" do
        expect(project.status).to eql("active")
      end

      it "has a human status name" do
        expect(project.human_status_name).to eql("Active")
      end
    end

    context "cancelled projects" do
      subject(:project) { create(:project) }
      before { project.cancel }

      it "begins with a fail status" do
        expect(project.status).to eql("fail")
      end

      it "has a human status name" do
        expect(project.human_status_name).to eql("Canned")
      end
    end

    context "completed projects" do
      subject(:project) { create(:project) }
      before { project.complete }

      it "has a done status" do
        expect(project.status).to eql("done")
      end

      it "has a human status name" do
        expect(project.human_status_name).to eql("DONE!")
      end
    end
  end
end
