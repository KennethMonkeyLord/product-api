import http from 'k6/http';
import {
  check,
  randomSeed,
  sleep,
} from 'k6';

export let options = {
  stages: [
    { duration: '10s', target: 100 },
    { duration: '20s', target: 300 },
    { duration: '10s', target: 0 },
  ],
  thresholds: {
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<500', 'max<2000'],
  }
};
const localhost = 'http://localhost:3001';

randomSeed(0);

export default function () {
  const max = 1000011;
  let product_id = Math.floor(Math.random() * max) || 1;
  let res = http.get(`${localhost}/products/${product_id}`, {
    tags: { name: 'GetForProducts' },
  });
  check(res, {
    'response code was 200': (res) => res.status === 200,
    'response duration < 2000ms ': (res) => res.timings.duration < 2000,
  });
  sleep(1);
}