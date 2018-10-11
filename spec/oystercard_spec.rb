require 'oystercard'

describe Oystercard do
  
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end
  
  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    
    it 'top up balance' do
      expect{ subject.top_up 1}.to change{ subject.balance }.by 1
    end 
  end
  
  it 'raises and error if maximum balance is exceeded' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up maximum_balance
    expect{ subject.top_up 1}.to raise_error 'Maximum balance of #{maximum_balance} exceeded!'
  end
    
  it { is_expected.to respond_to(:deduct).with(1).argument }
    
  it 'deducts from balance' do
    subject.top_up(20)
    expect{ subject.deduct 3}.to change{ subject.balance }.by -3
  end
  
  it 'is initially not on way' do
    expect(subject).not_to be_on_way
  end
  
  it 'touch in' do
    subject.touch_in
    expect(subject).to be_on_way
  end
  
  it 'touch out' do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_on_way
  end
  
  it 'will not touch in below the minimun balance' do
    expect{ subject.touch_in }.to raise_error "Insufficient balance!"
  end
  
end