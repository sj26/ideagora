require 'spec_helper'

describe TalksHelper do
  describe '#casual_day_description(time)' do
    let(:monday) { Date.new(2011, 5, 30) } # Mon, May 30 2011
    before { Timecop.freeze(monday.beginning_of_day) }

    context '+time+ is sometime before yesterday (last monday)' do
      subject { helper.casual_day_description(monday - 7.days) }
      it { should == "Monday, 23 May, 2011" }
    end

    context '+time+ is sometime yesterday (last sunday)' do
      subject { helper.casual_day_description(monday - 1.days) }
      it { should == "Yesterday" }
    end

    context '+time+ is sometime today (monday)' do
      subject { helper.casual_day_description(monday) }
      it { should == "Today" }
    end

    context '+time+ is sometime tomorrow (this tuesday)' do
      subject { helper.casual_day_description(monday + 1.day) }
      it { should == "Tomorrow" }
    end

    context '+time+ is sometime this wednesday' do
      subject { helper.casual_day_description(monday + 2.days) }
      it { should == "This Wednesday" }
    end

    context '+time+ is sometime this thursday' do
      subject { helper.casual_day_description(monday + 3.days) }
      it { should == "This Thursday" }
    end

    context '+time+ is sometime this friday' do
      subject { helper.casual_day_description(monday + 4.days) }
      it { should == "This Friday" }
    end

    context '+time+ is sometime this saturday' do
      subject { helper.casual_day_description(monday + 5.days) }
      it { should == "This Saturday" }
    end

    context '+time+ is sometime this sunday' do
      subject { helper.casual_day_description(monday + 6.days) }
      it { should == "This Sunday" }
    end

    context '+time+ is sometime this week' do
      subject { helper.casual_day_description(monday + 7.days) }
      it { should == "Monday, 06 June, 2011" }
    end
  end
end
