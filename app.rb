require('sinatra')
    require('sinatra/reloader')
    require('./lib/library')
    also_reload('lib/**/*.rb')
    get('/') do

    end
    get('/library') do

    end

    get('/library/new') do

    end

    get('/library/:id') do

    end
    post('/library') do

    end

    get('/library/:id/edit') do

    end

    patch('/library/:id') do

    end

    delete('/library/:id') do

    end

    get('/custom_route') do

    end
    