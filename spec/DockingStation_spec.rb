require './lib/docking_station'

describe DockingStation do
  subject(:station) {DockingStation.new}
  subject(:bike) {Bike.new}

  context 'responds to #release_bike' do
    it 'calls release_bike' do
      expect(station).to respond_to(:release_bike)
    end

    it 'is of the Bike class' do
      station.dock(bike)
      expect(station.release_bike).to be_instance_of(Bike)
    end

  end

  context 'checks if bike working' do
    it 'returns true' do
      expect(bike.working?).to eq(true)
    end
  end

  context 'be able to dock bike' do
    it 'docking station can dock bike' do
      expect(station).to respond_to(:dock)
    end

    it 'docking station returns bikes' do
      station.dock(bike)
      expect(station.bikes).to eq([bike])
    end

    it 'report bike as broken' do
      expect(bike).to respond_to(:report_broken)
    end

    it 'check a broken bike' do
      bike.report_broken
      expect(bike.working?).to eq(false)
    end

    it 'check dock wont release broken bike' do
      bike.report_broken
      station.dock(bike)
      expect{ station.release_bike }.to raise_error 'No bike available'
    end

  end

  context 'capacity tracked' do
    it 'raises error if no bikes in dock' do
      expect { station.release_bike }.to raise_error 'No bike available'
    end

    it 'raises error if dock hits capacity' do
      DockingStation::DEFAULT_CAPACITY.times { station.dock(bike) }
      expect { station.dock(bike) }.to raise_error 'Dock full'
    end

    it 'has variable capacity' do
      station_2 = DockingStation.new(72)
      72.times { station_2.dock(bike) }
      expect { station_2.dock(bike) }.to raise_error 'Dock full'
    end
  end





end
