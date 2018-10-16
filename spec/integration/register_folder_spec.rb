RSpec.describe Dry::System::Rails, 'register_folder!' do
  context 'schema folder' do
    before do
      class Test::Container < Dry::System::Container
        extend Dry::System::Rails::Resolver

        configure do |config|
          config.root = SPEC_ROOT.join('fixtures').realpath
        end

        lib_folder! 'transactions'
        register_folder! 'user/schema', resolver: ->(k) { k }
      end

      Test::Container.finalize!
    end

    it { expect(Test::Container['user.schema.create']).to eq(User::Schema::Create) }
    it { expect(Test::Container['user.schema.update']).to eq(User::Schema::Update) }

    it { expect(Test::Container['user.schema.create']).to respond_to(:call) }
    it { expect(Test::Container['user.schema.update']).to respond_to(:call) }
  end

  context 'transactions folder with custom resolver' do
    before do
      class Test::Container < Dry::System::Container
        extend Dry::System::Rails::Resolver

        configure do |config|
          config.root = SPEC_ROOT.join('fixtures').realpath
        end

        lib_folder! 'transactions'
        register_folder! 'user/transactions'
      end

      Test::Container.finalize!
    end

    it { expect(Test::Container['user.transactions.create']).to be_an_instance_of(User::Transactions::Create) }
    it { expect(Test::Container['user.transactions.update']).to be_an_instance_of(User::Transactions::Update) }

    it { expect(Test::Container['user.transactions.create']).to respond_to(:call) }
    it { expect(Test::Container['user.transactions.update']).to respond_to(:call) }
  end

  context 'two diferent folders' do
    before do
      class Test::Container < Dry::System::Container
        extend Dry::System::Rails::Resolver

        configure do |config|
          config.root = SPEC_ROOT.join('fixtures').realpath
        end

        lib_folder! 'transactions'
        register_folder! 'user/schema', resolver: ->(k) { k }
        register_folder! 'user/transactions'
      end

      Test::Container.finalize!
    end

    it { expect(Test::Container['user.schema.create']).to eq(User::Schema::Create) }
    it { expect(Test::Container['user.transactions.create']).to be_an_instance_of(User::Transactions::Create) }

    it { expect(Test::Container['user.schema.create']).to respond_to(:call) }
    it { expect(Test::Container['user.transactions.create']).to respond_to(:call) }
  end
end
