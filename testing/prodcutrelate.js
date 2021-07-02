import http from 'k6/http';
import {
  check,
  randomSeed,
  sleep,
} from 'k6';

export let options = {
  stages: [
    { duration: '30s', target: 30 },
    { duration: '60s', target: 100 },
    { duration: '30s', target: 0 },
  ],
  thresholds: {
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<150', 'max<250'],
  }
};
const localhost = 'http://localhost:3001';

randomSeed(0);

export default function () {
  const max = 1000011;
  let product_id = Math.floor(Math.random() * max) || 1;
  let res = http.get(`${localhost}/products/${product_id}/related`, {
    tags: { name: 'GetForProducts' },
  });
  check(res, {
    'response code was 200': (res) => res.status === 200,
    'response duration < 2000ms ': (res) => res.timings.duration < 2000,
  });
  sleep(1);
}