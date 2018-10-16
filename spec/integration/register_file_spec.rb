RSpec.describe Dry::System::Rails, 'register_file!' do
  context 'transaction file' do
    before do
      class Test::Container < Dry::System::Container
        extend Dry::System::Rails::Resolver

        configure do |config|
          config.root = SPEC_ROOT.join('fixtures').realpath
        end

        lib_folder! 'transactions'
        register_file! 'user/transactions/create'
      end

      Test::Container.finalize!
    end

    it { expect(Test::Container['user.transactions.create']).to be_instance_of(User::Transactions::Create) }
    it { expect(Test::Container['user.transactions.create']).to respond_to(:call) }
  end

  context 'schema file with custom resolver' do
    before do
      class Test::Container < Dry::System::Container
        extend Dry::System::Rails::Resolver

        configure do |config|
          config.root = SPEC_ROOT.join('fixtures').realpath
        end

        lib_folder! 'transactions'
        register_file! 'user/schema/create', resolver: ->(k) { k }
      end

      Test::Container.finalize!
    end

    it { expect(Test::Container['user.schema.create']).to eq(User::Schema::Create) }
    it { expect(Test::Container['user.schema.create']).to respond_to(:call) }
  end

  context 'two diferent files' do
    before do
      class Test::Container < Dry::System::Container
        extend Dry::System::Rails::Resolver

        configure do |config|
          config.root = SPEC_ROOT.join('fixtures').realpath
        end
        
        lib_folder! 'transactions'
        register_file! 'user/schema/create', resolver: ->(k) { k }
        register_file! 'user/transactions/create'
      end

      Test::Container.finalize!
    end

    it { expect(Test::Container['user.schema.create']).to eq(User::Schema::Create) }
    it { expect(Test::Container['user.transactions.create']).to be_instance_of(User::Transactions::Create) }

    it { expect(Test::Container['user.schema.create']).to respond_to(:call) }
    it { expect(Test::Container['user.transactions.create']).to respond_to(:call) }
  end
end
