'use strict'

const axios = require('axios')

module.exports = {
    hello: (event, context, callback) => {

        axios.get('https://httpbin.org/ip')
            .then(res => {
                const response = {
                    statusCode: 200,
                    body: JSON.stringify(res),
                };
                callback(null, response);
            })
            .error(err => {
                const response = {
                    statusCode: 500,
                    body: JSON.stringify(err),
                };
                callback(null, response);
            })
    },
    test: () => {
        [0,1,2,3,4,5,6,7,8,9].forEach((idx) => {
            const desc = `${idx} measure.`
            console.time(desc)
            axios.get('https://851zho2t25.execute-api.ap-northeast-1.amazonaws.com/dev/data')
                .then(res => {
                    console.timeEnd(desc)
                    console.log('=== success!')
                    console.log(res.data)
                })
                .catch(err => {
                    console.timeEnd(desc)
                    console.log('=== error!')
                    console.log(err.response.data)
                })
        })
        // Promise.all([0,1,2,3,4].map(() => axios.get('https://851zho2t25.execute-api.ap-northeast-1.amazonaws.com/dev/data')))
        //     .then(resAry => {
        //         console.log('===========result')
        //         resAry.forEach(res => {
        //             console.log(res)
        //         })
        //     })
        //     .catch(err => {
        //         console.log('===========error!')
        //         console.log(err)
        //     })
    },
};
